defmodule Overstats.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :type, :string

      timestamps()
    end
  end
end
