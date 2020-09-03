defmodule RateCoffee.Bevs.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :content, :string
    field :rating, :integer
    field :user_id, :id
    field :coffee_id, :id

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:content, :rating])
    |> validate_required([:content, :rating])
  end
end
