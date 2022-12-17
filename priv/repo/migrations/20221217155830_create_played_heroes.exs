defmodule Overstats.Repo.Migrations.CreatePlayedHeroes do
  use Ecto.Migration

  def change do
    create table(:played_heroes) do
      add :game, references(:games, on_delete: :delete_all)
      add :player, references(:players, on_delete: :delete_all)
      add :hero, references(:heroes, on_delete: :delete_all)

      timestamps()
    end

    create index(:played_heroes, [:game])
    create index(:played_heroes, [:player])
    create index(:played_heroes, [:hero])
  end
end
