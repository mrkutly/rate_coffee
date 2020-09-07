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

  def data() do
    Dataloader.Ecto.new(RateCoffee.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc false
  def changeset(roaster, attrs) do
    roaster
    |> cast(attrs, [:city, :state, :country, :name, :image])
    |> RateCoffee.Helpers.put_slug(attrs)
    |> validate_required([:city, :country, :name, :slug])
  end
end
