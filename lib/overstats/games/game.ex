defmodule Overstats.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :type, :string
    field :map, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
