defmodule RateCoffee.Repo.Migrations.AddSlugToRoasters do
  use Ecto.Migration

  def change do
    alter table(:roasters) do
      add :slug, :string
    end

    create index(:roasters, :slug)
  end
end
