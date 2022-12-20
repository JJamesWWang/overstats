defmodule Overstats.Repo.Migrations.CreateHeroes do
  use Ecto.Migration

  def change do
    create table(:heroes) do
      add :name, :string, null: false
      add :role, :string, null: false
    end

    create unique_index(:heroes, [:name])
  end
end
