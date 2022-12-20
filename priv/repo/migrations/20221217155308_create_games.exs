defmodule Overstats.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :mode, :string, null: false
      add :role_queue?, :boolean, null: false

      timestamps()
    end
  end
end
