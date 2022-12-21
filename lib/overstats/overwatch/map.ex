defmodule Overstats.Overwatch.Map do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maps" do
    field :name, :string
    field :type, :string
    field :img_url, :string
  end

  @doc false
  def changeset(map, attrs) do
    map
    |> cast(attrs, [:name, :type, :img_url])
    |> validate_required([:name, :type, :img_url])
    |> unique_constraint(:name)
  end
end
