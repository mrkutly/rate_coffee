defmodule RateCoffee.Bevs.Coffee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "coffees" do
    field :image, :string
    field :name, :string

    belongs_to(:region, RateCoffee.Bevs.Region)
    belongs_to(:roaster, RateCoffee.Bevs.Roaster)
    has_many(:reviews, RateCoffee.Bevs.Review)

    timestamps()
  end

  @doc false
  def changeset(coffee, attrs) do
    coffee
    |> cast(attrs, [:name, :image, :region_id, :roaster_id])
    |> validate_required([:name])
    |> foreign_key_constraint(:region_id)
    |> foreign_key_constraint(:roaster_id)
  end
end
