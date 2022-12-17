defmodule Overstats.Repo.Migrations.CreatePlaysOfTheGame do
  use Ecto.Migration

  def change do
    create table(:plays_of_the_game) do
      add :game, references(:games, on_delete: :delete_all)
      add :player, references(:players, on_delete: :delete_all)
      add :hero, references(:heroes, on_delete: :delete_all)

      timestamps()
    end

    create index(:plays_of_the_game, [:game])
    create index(:plays_of_the_game, [:player])
    create index(:plays_of_the_game, [:hero])
  end
end
