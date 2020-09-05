defmodule RateCoffee.Repo.Migrations.AddSlugToCoffees do
  use Ecto.Migration

  def change do
    alter table(:coffees) do
      add :slug, :string
    end

    create index(:coffees, :slug)
  end
end
