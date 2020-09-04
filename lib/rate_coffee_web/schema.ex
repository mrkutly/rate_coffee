defmodule RateCoffeeWeb.Schema do
  use Absinthe.Schema
  alias RateCoffeeWeb.Schema.Middleware
  import_types(__MODULE__.BevsTypes)

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
end
