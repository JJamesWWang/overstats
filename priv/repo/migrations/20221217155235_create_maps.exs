defmodule Overstats.Repo.Migrations.CreateMaps do
  use Ecto.Migration

  def change do
    create table(:maps) do
      add :name, :string
      add :type, :string
    end

    create unique_index(:maps, [:name])
  end
end
