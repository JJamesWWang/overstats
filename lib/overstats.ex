defmodule Overstats do
  @moduledoc """
  Overstats keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Overstats.Games
  alias Overstats.Players
  alias Overstats.Overwatch
  alias Overstats.Stats

  def create_game_with_stats(
        game_mode,
        map,
        won?,
        role_queue?,
        player_heroes,
        potg?,
        potg_player \\ nil,
        potg_hero \\ nil
      ) do
    map = Overwatch.get_map_by_name!(map)
    player_heroes = validate_player_heroes(player_heroes)

    with {:ok, game} <-
           Games.create_game(%{mode: game_mode, role_queue?: role_queue?, map_id: map.id}) do
      Enum.each(player_heroes, fn {player, heroes_played} ->
        Stats.create_played_game(%{won?: won?, game_id: game.id, player_id: player.id})

        Enum.each(heroes_played, fn hero ->
          Stats.create_played_hero(%{game_id: game.id, player_id: player.id, hero_id: hero.id})
        end)
      end)

      if potg? do
        potg_player = Players.get_player_by_name!(potg_player)
        potg_hero = Overwatch.get_hero_by_name!(potg_hero)

        Stats.create_play_of_the_game(%{
          game_id: game.id,
          player_id: potg_player.id,
          hero_id: potg_hero.id
        })
      end

      {:ok}
    else
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  # %{"player_name" => ["hero1", "hero2", "hero3"]}
  defp validate_player_heroes(player_heroes) do
    player_heroes
    |> Map.new(fn {player_name, heroes_played} ->
      player = Players.get_player_by_name!(player_name)

      heroes_played = heroes_played |> Enum.map(fn hero -> Overwatch.get_hero_by_name!(hero) end)

      {player, heroes_played}
    end)
  end
end
