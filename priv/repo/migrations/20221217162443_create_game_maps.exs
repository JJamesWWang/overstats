defmodule Overstats.Repo.Migrations.CreateGameMaps do
  use Ecto.Migration

  def change do
    create table(:game_maps) do
      add :game, references(:games, on_delete: :delete_all)
      add :map, references(:maps, on_delete: :delete_all)

      timestamps()
    end

    create index(:game_maps, [:game])
    create index(:game_maps, [:map])
  end
end
