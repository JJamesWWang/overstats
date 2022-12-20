defmodule Overstats.OverwatchFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Overstats.Overwatch` context.
  """

  @doc """
  Generate a hero.
  """
  def hero_fixture(attrs \\ %{}) do
    {:ok, hero} =
      attrs
      |> Enum.into(%{
        name: "some name #{System.unique_integer()}",
        role: "some role"
      })
      |> Overstats.Overwatch.create_hero()

    hero
  end

  @doc """
  Generate a map.
  """
  def map_fixture(attrs \\ %{}) do
    {:ok, map} =
      attrs
      |> Enum.into(%{
        name: "some name #{System.unique_integer()}",
        type: "some type"
      })
      |> Overstats.Overwatch.create_map()

    map
  end
end
