defmodule Overstats.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :mode, :string
    field :role_queue?, :boolean
    belongs_to :map, Overstats.Overwatch.Map

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:mode, :role_queue?, :map_id])
    |> validate_required([:mode, :role_queue?, :map_id])
    |> assoc_constraint(:map)
  end
end
