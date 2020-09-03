defmodule RateCoffee.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :content, :text, null: false
      add :rating, :integer, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :coffee_id, references(:coffees, on_delete: :delete_all)

      timestamps()
    end

    create index(:reviews, [:user_id])
    create index(:reviews, [:coffee_id])
    create constraint(:reviews, :rating_minmax_constraint, check: "rating >= 0 and rating < 101")
  end
end
