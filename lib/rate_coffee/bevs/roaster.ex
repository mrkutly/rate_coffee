defmodule RateCoffee.Bevs.Roaster do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> create_slug(attrs)
    |> cast(attrs, [:city, :state, :country, :name, :image, :slug])
    |> validate_required([:city, :country, :name])
  end

  def create_slug(roaster, attrs) do
    slug =
      attrs.name
      |> String.downcase()
      |> String.split()
      |> Enum.join("-")

    Map.put(roaster, :slug, slug)
  end
end
