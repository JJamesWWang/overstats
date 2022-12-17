defmodule Overstats.Stats.PlayOfTheGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plays_of_the_game" do
    belongs_to :game, Overstats.Games.Game
    belongs_to :player, Overstats.Players.Player
    belongs_to :hero, Overstats.Overwatch.Hero
  end

  @doc false
  def changeset(play_of_the_game, attrs) do
    play_of_the_game
    |> cast(attrs, [:game_id, :player_id, :hero_id])
    |> validate_required([:game_id, :player_id, :hero_id])
    |> assoc_constraint(:game)
    |> assoc_constraint(:player)
    |> assoc_constraint(:hero)
  end
end
