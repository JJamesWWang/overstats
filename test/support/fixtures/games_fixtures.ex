defmodule Overstats.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Overstats.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        type: "some type"
      })
      |> Overstats.Games.create_game()

    game
  end
end
