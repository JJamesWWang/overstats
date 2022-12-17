defmodule Overstats.Stats.PlayedGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_games" do
    field :won?, :boolean

    belongs_to :game, Overstats.Games.Game
    belongs_to :player, Overstats.Players.Player
  end

  @doc false
  def changeset(played_game, attrs) do
    played_game
    |> cast(attrs, [:won?])
    |> validate_required([:won?])
  end
end
