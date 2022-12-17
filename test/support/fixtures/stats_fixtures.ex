defmodule Overstats.StatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Overstats.Stats` context.
  """

  @doc """
  Generate a played_game.
  """
  def played_game_fixture(attrs \\ %{}) do
    {:ok, played_game} =
      attrs
      |> Enum.into(%{
        won?: true
      })
      |> Overstats.Stats.create_played_game()

    played_game
  end

  @doc """
  Generate a played_hero.
  """
  def played_hero_fixture(attrs \\ %{}) do
    {:ok, played_hero} =
      attrs
      |> Enum.into(%{

      })
      |> Overstats.Stats.create_played_hero()

    played_hero
  end

  @doc """
  Generate a play_of_the_game.
  """
  def play_of_the_game_fixture(attrs \\ %{}) do
    {:ok, play_of_the_game} =
      attrs
      |> Enum.into(%{

      })
      |> Overstats.Stats.create_play_of_the_game()

    play_of_the_game
  end

  @doc """
  Generate a game_map.
  """
  def game_map_fixture(attrs \\ %{}) do
    {:ok, game_map} =
      attrs
      |> Enum.into(%{

      })
      |> Overstats.Stats.create_game_map()

    game_map
  end
end
