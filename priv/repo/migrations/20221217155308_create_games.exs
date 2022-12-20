defmodule Overstats.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :mode, :string, null: false
      add :role_queue?, :boolean, null: false
      add :map_id, references(:maps, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:games, [:map_id])
  end
end
