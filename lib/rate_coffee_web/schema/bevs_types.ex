defmodule RateCoffeeWeb.Schema.BevsTypes do
  use Absinthe.Schema.Notation
  alias RateCoffeeWeb.Resolvers

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
    field(:id, :id)
    field(:image, :string)
    field(:name, :string)
  end

  input_object :coffee_filter do
    field(:name, :string)
    field(:roaster_id, :id)
    field(:region_id, :id)
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
