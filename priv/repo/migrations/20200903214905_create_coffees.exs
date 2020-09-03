defmodule RateCoffee.Repo.Migrations.CreateCoffees do
  use Ecto.Migration

  def change do
    create table(:coffees) do
      add :name, :string, null: false
      add :image, :string
      add :region_id, references(:regions, on_delete: :nothing)
      add :roaster_id, references(:roasters, on_delete: :nothing)

      timestamps()
    end

    create index(:coffees, [:region_id])
    create index(:coffees, [:roaster_id])
  end
end
