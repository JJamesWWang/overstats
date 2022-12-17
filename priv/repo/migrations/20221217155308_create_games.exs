defmodule Overstats.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :type, :string
      add :map, references(:maps, on_delete: :nothing)

      timestamps()
    end
  end
end
