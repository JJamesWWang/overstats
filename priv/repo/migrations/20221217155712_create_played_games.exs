defmodule Overstats.Repo.Migrations.CreatePlayedGames do
  use Ecto.Migration

  def change do
    create table(:played_games) do
      add :won?, :boolean, null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :player_id, references(:players, on_delete: :delete_all), null: false
    end

    create index(:played_games, [:game_id])
    create index(:played_games, [:player_id])
    create unique_index(:played_games, [:game_id, :player_id])
  end
end
