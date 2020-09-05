defmodule RateCoffee.Repo.Migrations.AddSlugToRoasters do
  use Ecto.Migration

  def change do
    alter table(:roasters) do
      add :slug, :string, null: false
    end

    create index(:roasters, :slug)
  end
end
