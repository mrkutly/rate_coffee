defmodule RateCoffeeWeb.Schema.BevsTypes do
  use Absinthe.Schema.Notation
  alias RateCoffeeWeb.Resolvers
  alias RateCoffee.Bevs.{Coffee, Region, Review, Roaster}
  alias RateCoffee.UserManager.User
  import Absinthe.Resolution.Helpers

  object :bevs_queries do
    field :coffees, list_of(:coffee), description: "Filtered list of all coffees" do
      arg(:filter, :coffee_filter)
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Bevs.get_coffees/3)
    end

    field :coffee, :coffee, description: "One coffee by id" do
      arg(:id, :id)
      resolve(&Resolvers.Bevs.get_coffee/3)
    end

    field :roasters, list_of(:roaster), description: "Filtered list of all roasters" do
      arg(:filter, :roaster_filter)
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Bevs.get_roasters/3)
    end

    field :roaster, :roaster, description: "One roaster by id" do
      arg(:id, :id)
      resolve(&Resolvers.Bevs.get_roaster/3)
    end
  end

  object :bevs_mutations do
    field :create_coffee, :coffee_result, description: "Create a coffee" do
      arg(:input, non_null(:coffee_input))
      resolve(&Resolvers.Bevs.create_coffee/3)
    end
  end

  object :coffee do
    field(:id, non_null(:id))
    field(:image, :string)
    field(:name, non_null(:string))
    field(:slug, non_null(:string))

    field :region, non_null(:region), resolve: dataloader(Region)
    field :roaster, non_null(:roaster), resolve: dataloader(Roaster)
    field :reviews, list_of(:review), resolve: dataloader(Review)

    field :average_rating, :decimal do
      resolve(fn coffee, _, _ ->
        batch({Resolvers.Bevs, :get_average_rating_for_coffees}, coffee.id, fn batch_results ->
          {:ok, Map.get(batch_results, coffee.id)}
        end)
      end)
    end
  end

  object :review do
    field(:id, non_null(:id))
    field(:content, non_null(:string))
    field(:rating, non_null(:integer))
    field :user, non_null(:user), resolve: dataloader(User)
    field :coffee, non_null(:coffee), resolve: dataloader(Coffee)
  end

  object :region do
    field(:country, non_null(:string))
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field :coffees, list_of(:coffee), resolve: dataloader(Coffee)
  end

  object :roaster do
    field(:city, non_null(:string))
    field(:country, non_null(:string))
    field(:id, non_null(:id))
    field(:image, :string)
    field(:name, non_null(:string))
    field(:slug, non_null(:string))
    field(:state, :string)
    field :coffees, list_of(:coffee), resolve: dataloader(Coffee)
  end

  input_object :coffee_filter do
    field(:name, :string)
    field(:roaster_id, :id)
    field(:region_id, :id)
  end

  input_object :roaster_filter do
    field(:city, :string)
    field(:country, :string)
    field(:name, :string)
    field(:state, :string)
  end

  input_object :coffee_input do
    field(:image, :string)
    field(:name, non_null(:string))
    field(:roaster_id, non_null(:id))
    field(:region_id, non_null(:id))
  end

  object :coffee_result do
    field(:coffee, :coffee)
    field(:errors, list_of(:input_error))
  end
end
