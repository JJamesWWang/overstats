defmodule Overstats.Repo.Migrations.CreatePlayedHeroes do
  use Ecto.Migration

  def change do
    create table(:played_heroes) do
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :player_id, references(:players, on_delete: :delete_all), null: false
      add :hero_id, references(:heroes, on_delete: :delete_all), null: false
    end

    create index(:played_heroes, [:game_id])
    create index(:played_heroes, [:player_id])
    create index(:played_heroes, [:hero_id])
    create unique_index(:played_heroes, [:game_id, :player_id, :hero_id])
  end
end
