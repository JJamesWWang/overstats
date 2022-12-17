defmodule Overstats.PlayersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Overstats.Players` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Overstats.Players.create_player()

    player
  end
end
