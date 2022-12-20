defmodule Overstats.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Overstats.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    map = Overstats.OverwatchFixtures.map_fixture()

    {:ok, game} =
      attrs
      |> Enum.into(%{
        mode: "some mode",
        role_queue?: true,
        map_id: map.id
      })
      |> Overstats.Games.create_game()

    game
  end
end
