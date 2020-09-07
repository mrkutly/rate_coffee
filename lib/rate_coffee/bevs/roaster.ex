defmodule RateCoffee.Bevs.Roaster do
  import Ecto.Changeset
  use Ecto.Schema
  use RateCoffee.Dataloader

  schema "roasters" do
    field :city, :string
    field :country, :string
    field :image, :string
    field :name, :string
    field :slug, :string
    field :state, :string

    has_many(:coffees, RateCoffee.Bevs.Coffee)

    timestamps()
  end

  @doc false
  def changeset(roaster, attrs) do
    roaster
    |> cast(attrs, [:city, :state, :country, :name, :image])
    |> RateCoffee.Helpers.put_slug(attrs)
    |> validate_required([:city, :country, :name, :slug])
  end
end
