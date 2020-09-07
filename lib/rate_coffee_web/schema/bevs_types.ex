defmodule RateCoffeeWeb.Schema.BevsTypes do
  use Absinthe.Schema.Notation
  alias RateCoffeeWeb.Resolvers
  alias RateCoffeeWeb.Schema.Helpers
  alias RateCoffee.Bevs.Coffee

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

    field :average_rating, :decimal do
      resolve(fn coffee, _, _ ->
        batch({Resolvers.Bevs, :get_average_rating_for_coffees}, coffee.id, fn batch_results ->
          {:ok, Map.get(batch_results, coffee.id)}
        end)
      end)
    end
  end

  input_object :coffee_filter do
    field(:name, non_null(:string))
    field(:roaster_id, non_null(:id))
    field(:region_id, non_null(:id))
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
