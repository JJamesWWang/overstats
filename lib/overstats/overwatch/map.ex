defmodule Overstats.Overwatch.Map do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maps" do
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(map, attrs) do
    map
    |> cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
  end
end
