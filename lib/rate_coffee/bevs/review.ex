defmodule RateCoffee.Bevs.Review do
  use Ecto.Schema
  use RateCoffee.Dataloader
  import Ecto.Changeset

  schema "reviews" do
    field :content, :string
    field :rating, :integer

    belongs_to(:coffee, RateCoffee.Bevs.Coffee)
    belongs_to(:user, RateCoffee.UserManager.User)

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:content, :rating, :coffee_id, :user_id])
    |> validate_required([:content, :rating])
    |> foreign_key_constraint(:coffee_id)
    |> foreign_key_constraint(:user_id)
  end
end
