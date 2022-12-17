defmodule Overstats.Stats.PlayedHero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_heroes" do

    field :game, :id
    field :player, :id
    field :hero, :id

    timestamps()
  end

  @doc false
  def changeset(played_hero, attrs) do
    played_hero
    |> cast(attrs, [])
    |> validate_required([])
  end
end
