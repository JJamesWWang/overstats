defmodule Overstats.Repo.Migrations.CreatePlaysOfTheGame do
  use Ecto.Migration

  def change do
    create table(:plays_of_the_game) do
      add :game, references(:games, on_delete: :nothing)
      add :player, references(:players, on_delete: :nothing)
      add :hero, references(:heroes, on_delete: :nothing)

      timestamps()
    end

    create index(:plays_of_the_game, [:game])
    create index(:plays_of_the_game, [:player])
    create index(:plays_of_the_game, [:hero])
  end
end
