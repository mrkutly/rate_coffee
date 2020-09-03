defmodule RateCoffee.Bevs.Region do
  use Ecto.Schema
  import Ecto.Changeset

  schema "regions" do
    field :country, :string
    field :name, :string

    has_many(:coffees, RateCoffee.Bevs.Coffee)
    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name, :country])
    |> validate_required([:name, :country])
  end
end
