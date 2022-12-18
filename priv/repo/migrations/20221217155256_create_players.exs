defmodule Overstats.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string

      timestamps()
    end

    create unique_index(:players, [:name])
  end
end
