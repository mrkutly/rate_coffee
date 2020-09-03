defmodule RateCoffee.Repo.Migrations.CreateRoasters do
  use Ecto.Migration

  def change do
    create table(:roasters) do
      add :city, :string, null: false
      add :state, :string
      add :country, :string, null: false
      add :name, :string, null: false
      add :image, :string

      timestamps()
    end

    create index(:roasters, [:name])
  end
end
