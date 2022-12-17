defmodule Overstats.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :mode, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:mode])
    |> validate_required([:mode])
  end
end
