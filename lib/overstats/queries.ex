defmodule Overstats.Queries do
  import Ecto.Query
  alias Overstats.Repo
  alias Overstats.Games.Game
  alias Overstats.Players.Player
  alias Overstats.Overwatch
  alias Overstats.Overwatch.{Hero}
  alias Overstats.Stats.{PlayedGame, PlayedHero, PlayOfTheGame}

  @doc """
  Returns all games in a serialized format as a map in which the key is the game id and
  the value is the serialized data.

  ## Examples

      iex> list_games_with_stats()
      %{
        1 => %{
                game_id: 1,
                game_mode: "Competitive",
                role_queue?: true,
                won?: true,
                map: %{name: "Dorado", img_url: "https://url.com"}
                players: ["Player1", "Player2", "Player3", "Player4", "Player5"],
                player_heroes: %{
                  "Player1" => ["Hero1", "Hero2"],
                  "Player2" => ["Hero3", "Hero4"],
                  "Player3" => ["Hero5", "Hero6"],
                  "Player4" => ["Hero7", "Hero8"],
                  "Player5" => ["Hero9", "Hero10"]
                },
                potg_player: "Player1",
                potg_hero: "Hero1"
              },
        2 => %{..., potg_player: nil, potg_hero: nil}
      }
  """
  def list_games_with_stats() do
    # Get all games with their maps, what players played them, and what heroes they played
    Repo.all(Game)
    |> Repo.preload([:map])
    |> Map.new(fn game ->
      players = get_players_of_game(game.id)

      player_heroes =
        players
        |> Map.new(fn player ->
          {player.name,
           get_heroes_of_player(game.id, player.id)
           |> Enum.map(fn hero -> hero.name end)}
        end)

      {potg_player, potg_hero} = get_potg(game.id)

      {game.id,
       %{
         game_id: game.id,
         game_mode: game.mode,
         role_queue?: game.role_queue?,
         won?: get_team_won?(game.id, players),
         map: %{name: game.map.name, img_url: game.map.img_url},
         players: players |> Enum.map(fn player -> player.name end),
         player_heroes: player_heroes,
         potg_player: potg_player,
         potg_hero: potg_hero
       }}
    end)
  end

  defp get_players_of_game(game_id) do
    Repo.all(
      from p in Player,
        join: pg in PlayedGame,
        on: pg.player_id == p.id,
        where: pg.game_id == ^game_id,
        select: p
    )
  end

  defp get_team_won?(game_id, players) do
    players = players |> Enum.reject(&(&1.name == "Random")) |> Enum.map(& &1.id)

    Repo.all(
      from pg in PlayedGame,
        where: pg.player_id in ^players and pg.game_id == ^game_id,
        select: pg.won?
    )
    |> Enum.any?()
  end

  defp get_heroes_of_player(game_id, player_id) do
    Repo.all(
      from h in Hero,
        join: ph in PlayedHero,
        on: ph.hero_id == h.id,
        where: ph.game_id == ^game_id and ph.player_id == ^player_id,
        select: h
    )
  end

  defp get_potg(game_id) do
    case Repo.one(
           from potg in PlayOfTheGame,
             where: potg.game_id == ^game_id,
             join: p in Player,
             on: p.id == potg.player_id,
             join: h in Hero,
             on: h.id == potg.hero_id,
             select: {p, h}
         ) do
      {player, hero} ->
        {player.name, hero.name}

      nil ->
        {nil, nil}
    end
  end

  @doc """
  Returns all of the stats data aggregated for all players, serialized in the format
  that the StatsHook expects.

  ## Examples

      iex> get_all_stats()

  """
  def get_all_stats() do
    %{
      win_rate: get_win_rate(),
      win_rate_by_hero: get_win_rate_by_hero(),
      win_rate_by_map: get_win_rate_by_map(),
      win_rate_by_map_type: get_win_rate_by_map_type(),
      win_rate_by_role: get_win_rate_by_role(),
      role_selection_bias: get_role_selection_bias()
    }
  end

  @doc """
  Returns all of the stats data for a player, serialized in the format that the
  StatsHook expects.

  ## Examples

      iex> get_all_stats()

  """
  def get_player_stats(player) do
    %{
      win_rate: get_win_rate(player),
      win_rate_by_hero: get_win_rate_by_hero(player),
      win_rate_by_map: get_win_rate_by_map(player),
      win_rate_by_map_type: get_win_rate_by_map_type(player),
      win_rate_by_role: get_win_rate_by_role(player),
      role_selection_bias: get_role_selection_bias(player)
    }
  end

  defp get_win_rate() do
    win_count =
      Repo.all(
        from pg in PlayedGame,
          join: p in Player,
          on: pg.player_id == p.id,
          where: p.name != "Random",
          where: pg.won?,
          group_by: pg.game_id,
          select: count(pg.game_id)
      )
      |> Enum.count()

    total_count =
      Repo.all(
        from pg in PlayedGame,
          join: p in Player,
          on: pg.player_id == p.id,
          where: p.name != "Random",
          group_by: pg.game_id,
          select: count(pg.game_id)
      )
      |> Enum.count()

    if total_count == 0 do
      0
    else
      win_count / total_count
    end
  end

  defp get_win_rate(player) do
    win_count =
      Repo.all(
        from pg in PlayedGame,
          where: pg.player_id == ^player.id and pg.won?,
          group_by: pg.game_id,
          select: count(pg.game_id)
      )
      |> Enum.count()

    total_count =
      Repo.all(
        from pg in PlayedGame,
          where: pg.player_id == ^player.id,
          group_by: pg.game_id,
          select: count(pg.game_id)
      )
      |> Enum.count()

    if total_count == 0 do
      0
    else
      win_count / total_count
    end
  end

  defp get_win_rate_by_hero() do
    win_by_hero =
      from pg in PlayedGame,
        where: pg.won?,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == pg.player_id,
        group_by: ph.hero_id,
        select: %{hero_id: ph.hero_id, count: count(ph.hero_id)}

    total_by_hero =
      from pg in PlayedGame,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == pg.player_id,
        group_by: ph.hero_id,
        select: %{hero_id: ph.hero_id, count: count(ph.hero_id)}

    Repo.all(
      from w in subquery(win_by_hero),
        right_join: t in subquery(total_by_hero),
        on: w.hero_id == t.hero_id,
        join: h in Hero,
        on: h.id == t.hero_id,
        select: {h.name, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {hero, win_count, total_count} ->
      %{hero: hero, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_hero(player) do
    win_by_hero =
      from pg in PlayedGame,
        where: pg.won?,
        where: pg.player_id == ^player.id,
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == pg.player_id,
        group_by: ph.hero_id,
        select: %{hero_id: ph.hero_id, count: count(ph.hero_id)}

    total_by_hero =
      from pg in PlayedGame,
        where: pg.player_id == ^player.id,
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == pg.player_id,
        group_by: ph.hero_id,
        select: %{hero_id: ph.hero_id, count: count(ph.hero_id)}

    Repo.all(
      from w in subquery(win_by_hero),
        right_join: t in subquery(total_by_hero),
        on: w.hero_id == t.hero_id,
        join: h in Hero,
        on: h.id == t.hero_id,
        select: {h.name, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {hero, win_count, total_count} ->
      %{hero: hero, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_map() do
    win_by_map =
      from pg in PlayedGame,
        where: pg.won?,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.id,
        select: %{map_id: m.id, count: count(m.id)}

    total_by_map =
      from pg in PlayedGame,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.id,
        select: %{map_id: m.id, count: count(m.id)}

    Repo.all(
      from w in subquery(win_by_map),
        right_join: t in subquery(total_by_map),
        on: w.map_id == t.map_id,
        join: m in Overwatch.Map,
        on: m.id == t.map_id,
        select: {m.name, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {map, win_count, total_count} ->
      %{map: map, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_map(player) do
    win_by_map =
      from pg in PlayedGame,
        where: pg.won?,
        where: pg.player_id == ^player.id,
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.id,
        select: %{map_id: m.id, count: count(m.id)}

    total_by_map =
      from pg in PlayedGame,
        where: pg.player_id == ^player.id,
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.id,
        select: %{map_id: m.id, count: count(m.id)}

    Repo.all(
      from w in subquery(win_by_map),
        right_join: t in subquery(total_by_map),
        on: w.map_id == t.map_id,
        join: m in Overwatch.Map,
        on: m.id == t.map_id,
        select: {m.name, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {map, win_count, total_count} ->
      %{map: map, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_map_type() do
    win_by_map_type =
      from pg in PlayedGame,
        where: pg.won?,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.type,
        select: %{map_type: m.type, count: count(m.type)}

    total_by_map_type =
      from pg in PlayedGame,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.type,
        select: %{map_type: m.type, count: count(m.type)}

    Repo.all(
      from w in subquery(win_by_map_type),
        right_join: t in subquery(total_by_map_type),
        on: w.map_type == t.map_type,
        select: {t.map_type, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {map_type, win_count, total_count} ->
      %{map_type: map_type, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_map_type(player) do
    win_by_map_type =
      from pg in PlayedGame,
        where: pg.won?,
        where: pg.player_id == ^player.id,
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.type,
        select: %{map_type: m.type, count: count(m.type)}

    total_by_map_type =
      from pg in PlayedGame,
        where: pg.player_id == ^player.id,
        join: g in Game,
        on: g.id == pg.game_id,
        join: m in Overwatch.Map,
        on: m.id == g.map_id,
        group_by: m.type,
        select: %{map_type: m.type, count: count(m.type)}

    Repo.all(
      from w in subquery(win_by_map_type),
        right_join: t in subquery(total_by_map_type),
        on: w.map_type == t.map_type,
        select: {t.map_type, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {map_type, win_count, total_count} ->
      %{map_type: map_type, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_role() do
    win_by_role =
      from pg in PlayedGame,
        where: pg.won?,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == p.id,
        join: h in Hero,
        on: h.id == ph.hero_id,
        group_by: h.role,
        select: %{role: h.role, count: count(h.role)}

    total_by_role =
      from pg in PlayedGame,
        join: p in Player,
        on: pg.player_id == p.id,
        where: p.name != "Random",
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == p.id,
        join: h in Hero,
        on: h.id == ph.hero_id,
        group_by: h.role,
        select: %{role: h.role, count: count(h.role)}

    Repo.all(
      from w in subquery(win_by_role),
        right_join: t in subquery(total_by_role),
        on: w.role == t.role,
        select: {t.role, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {role, win_count, total_count} ->
      %{role: role, win_rate: win_count / total_count}
    end)
  end

  defp get_win_rate_by_role(player) do
    win_by_role =
      from pg in PlayedGame,
        where: pg.won?,
        where: pg.player_id == ^player.id,
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == ^player.id,
        join: h in Hero,
        on: h.id == ph.hero_id,
        group_by: h.role,
        select: %{role: h.role, count: count(h.role)}

    total_by_role =
      from pg in PlayedGame,
        where: pg.player_id == ^player.id,
        join: ph in PlayedHero,
        on: ph.game_id == pg.game_id and ph.player_id == ^player.id,
        join: h in Hero,
        on: h.id == ph.hero_id,
        group_by: h.role,
        select: %{role: h.role, count: count(h.role)}

    Repo.all(
      from w in subquery(win_by_role),
        right_join: t in subquery(total_by_role),
        on: w.role == t.role,
        select: {t.role, w.count |> coalesce(0), t.count}
    )
    |> Enum.sort(fn {_, w1, t1}, {_, w2, t2} -> w1 / t1 > w2 / t2 end)
    |> Enum.map(fn {role, win_count, total_count} ->
      %{role: role, win_rate: win_count / total_count}
    end)
  end

  defp get_role_selection_bias() do
    total = Repo.one(from ph in PlayedHero, select: count(ph.id))

    Repo.all(
      from ph in PlayedHero,
        join: p in Player,
        on: ph.player_id == p.id,
        where: p.name != "Random",
        right_join: h in Hero,
        on: h.id == ph.hero_id,
        group_by: h.role,
        select: {h.role, count(h.role) |> coalesce(0)}
    )
    |> Enum.map(fn {role, count} -> %{role: role, count: count, fullMark: total} end)
  end

  defp get_role_selection_bias(player) do
    total = Repo.one(from ph in PlayedHero, select: count(ph.id))

    Overwatch.list_roles()
    |> Enum.map(fn role ->
      %{
        role: role,
        count:
          Repo.one(
            from ph in PlayedHero,
              where: ph.player_id == ^player.id,
              right_join: h in Hero,
              on: h.id == ph.hero_id,
              where: h.role == ^role,
              select: count(h.role)
          ),
        fullMark: total
      }
    end)
  end
end
