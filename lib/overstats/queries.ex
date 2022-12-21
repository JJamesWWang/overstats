defmodule Overstats.Queries do
  import Ecto.Query
  alias Overstats.Repo
  alias Overstats.Games.Game
  alias Overstats.Players.Player
  alias Overstats.Overwatch.{Hero}
  alias Overstats.Stats.{PlayedGame, PlayedHero, PlayOfTheGame}

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
         won?: get_team_won?(players),
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

  defp get_team_won?(players) do
    players = players |> Enum.reject(&(&1.name == "Random")) |> Enum.map(& &1.id)

    Repo.all(
      from pg in PlayedGame,
        where: pg.player_id in ^players,
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
end
