defmodule Overstats.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:players, [:name])
  end
end
