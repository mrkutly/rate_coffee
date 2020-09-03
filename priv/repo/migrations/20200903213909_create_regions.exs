defmodule RateCoffee.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions) do
      add :name, :string, null: false
      add :country, :string, null: false

      timestamps()
    end

    create index(:regions, [:name])
    create index(:regions, [:country])
    create index(:regions, [:country, :name], unique: true)
  end
end
