defmodule Overstats.Stats.GameMap do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_maps" do

    field :game, :id
    field :map, :id

    timestamps()
  end

  @doc false
  def changeset(game_map, attrs) do
    game_map
    |> cast(attrs, [])
    |> validate_required([])
  end
end
