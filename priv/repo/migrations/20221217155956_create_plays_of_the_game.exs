defmodule Overstats.Repo.Migrations.CreatePlaysOfTheGame do
  use Ecto.Migration

  def change do
    create table(:plays_of_the_game) do
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :player_id, references(:players, on_delete: :delete_all), null: false
      add :hero_id, references(:heroes, on_delete: :delete_all), null: false
    end

    create unique_index(:plays_of_the_game, [:game_id])
    create index(:plays_of_the_game, [:player_id])
    create index(:plays_of_the_game, [:hero_id])
  end
end
