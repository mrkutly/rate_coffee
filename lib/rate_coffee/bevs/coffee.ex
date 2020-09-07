defmodule RateCoffee.Bevs.Coffee do
  import Ecto.Changeset
  use Ecto.Schema
  use RateCoffee.Dataloader

  schema "coffees" do
    field :image, :string
    field :name, :string
    field :slug, :string
    field :average_rating, :integer, virtual: true
    belongs_to(:region, RateCoffee.Bevs.Region)
    belongs_to(:roaster, RateCoffee.Bevs.Roaster)
    has_many(:reviews, RateCoffee.Bevs.Review)

    timestamps()
  end

  @doc false
  def changeset(coffee, attrs) do
    coffee
    |> cast(attrs, [:region_id, :name, :image, :roaster_id])
    |> RateCoffee.Helpers.put_slug(attrs)
    |> validate_required([:name, :slug])
    |> foreign_key_constraint(:region_id)
    |> foreign_key_constraint(:roaster_id)
  end
end
