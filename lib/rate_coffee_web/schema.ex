defmodule RateCoffeeWeb.Schema do
  use Absinthe.Schema
  alias Absinthe.Blueprint.Input
  alias RateCoffeeWeb.Schema.Middleware
  alias RateCoffee.Bevs.{Coffee, Region, Roaster}

  import_types(__MODULE__.BevsTypes)
  import_types(__MODULE__.UserManagerTypes)

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Coffee, Coffee.data())
      |> Dataloader.add_source(Region, Region.data())
      |> Dataloader.add_source(Roaster, Roaster.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  query do
    import_fields(:bevs_queries)
  end

  mutation do
    import_fields(:bevs_mutations)
    import_fields(:user_manager_mutations)
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  scalar :email do
    parse(fn input ->
      with %Input.String{value: value} <- input,
           {true, email} <- {Regex.match?(~r(^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$), value), value} do
        {:ok, email}
      else
        _ -> :error
      end
    end)

    serialize(& &1)
  end

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        Decimal.parse(value)

      _, _ ->
        :error
    end)

    serialize(&to_string/1)
  end
end
