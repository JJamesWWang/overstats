defmodule Overstats.Repo.Migrations.CreateMaps do
  use Ecto.Migration

  def change do
    create table(:maps) do
      add :name, :string, null: false
      add :type, :string, null: false
    end

    create unique_index(:maps, [:name])
  end
end
