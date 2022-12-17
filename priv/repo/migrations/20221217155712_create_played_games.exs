defmodule Overstats.Repo.Migrations.CreatePlayedGames do
  use Ecto.Migration

  def change do
    create table(:played_games) do
      add :won?, :boolean, null: false
      add :game, references(:games, on_delete: :nothing)
      add :player, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:played_games, [:game])
    create index(:played_games, [:player])
  end
end
