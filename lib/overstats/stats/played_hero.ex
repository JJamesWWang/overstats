defmodule Overstats.Stats.PlayedHero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_heroes" do
    belongs_to :game, Overstats.Games.Game
    belongs_to :player, Overstats.Players.Player
    belongs_to :hero, Overstats.Overwatch.Hero

    timestamps()
  end

  @doc false
  def changeset(played_hero, attrs) do
    played_hero
    |> cast(attrs, [])
    |> validate_required([])
  end
end
