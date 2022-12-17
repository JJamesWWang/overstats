defmodule Overstats.Repo.Migrations.CreateGameMaps do
  use Ecto.Migration

  def change do
    create table(:game_maps) do
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :map_id, references(:maps, on_delete: :delete_all), null: false
    end

    create unique_index(:game_maps, [:game_id])
    create index(:game_maps, [:map_id])
  end
end
