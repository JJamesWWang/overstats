defmodule Overstats.Overwatch.Hero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "heroes" do
    field :name, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(hero, attrs) do
    hero
    |> cast(attrs, [:name, :role])
    |> validate_required([:name, :role])
  end
end
