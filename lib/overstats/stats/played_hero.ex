defmodule Overstats.Stats.PlayedHero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_heroes" do
    belongs_to :game, Overstats.Games.Game
    belongs_to :player, Overstats.Players.Player
    belongs_to :hero, Overstats.Overwatch.Hero
  end

  @doc false
  def changeset(played_hero, attrs) do
    played_hero
    |> cast(attrs, [:game_id, :player_id, :hero_id])
    |> validate_required([:game_id, :player_id, :hero_id])
    |> assoc_constraint(:game)
    |> assoc_constraint(:player)
    |> assoc_constraint(:hero)
  end
end
