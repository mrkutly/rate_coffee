defmodule RateCoffee.Bevs.Roaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roasters" do
    field :city, :string
    field :country, :string
    field :image, :string
    field :name, :string
    field :state, :string

    has_many(:coffees, RateCoffee.Bevs.Coffee)

    timestamps()
  end

  @doc false
  def changeset(roaster, attrs) do
    roaster
    |> cast(attrs, [:city, :state, :country, :name, :image])
    |> validate_required([:city, :country, :name])
  end
end
