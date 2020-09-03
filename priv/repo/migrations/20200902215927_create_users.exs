defmodule RateCoffee.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :thumbnail, :string

      timestamps()
    end

    create index(:users, [:email], unique: true)
    create index(:users, [:username], unique: true)
  end
end
