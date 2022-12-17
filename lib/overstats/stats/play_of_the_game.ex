defmodule Overstats.Stats.PlayOfTheGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plays_of_the_game" do

    field :game, :id
    field :player, :id
    field :hero, :id

    timestamps()
  end

  @doc false
  def changeset(play_of_the_game, attrs) do
    play_of_the_game
    |> cast(attrs, [])
    |> validate_required([])
  end
end
