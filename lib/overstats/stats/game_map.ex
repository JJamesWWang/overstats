defmodule Overstats.Stats.GameMap do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_maps" do
    belongs_to :game, Overstats.Games.Game
    belongs_to :map, Overstats.Overwatch.Map
  end

  @doc false
  def changeset(game_map, attrs) do
    game_map
    |> cast(attrs, [:game_id, :map_id])
    |> validate_required([:game_id, :map_id])
    |> assoc_constraint(:game)
    |> assoc_constraint(:map)
    |> unique_constraint([:game_id])
  end
end
