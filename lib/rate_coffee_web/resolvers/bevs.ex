defmodule RateCoffeeWeb.Resolvers.Bevs do
  alias RateCoffee.Bevs
  alias RateCoffee.Repo
  import Ecto.Query

  def create_coffee(_, %{input: input}, _) do
    with {:ok, coffee} <- Bevs.create_coffee(input) do
      {:ok, %{coffee: coffee}}
    end
  end

  def get_coffees(_, args, _) do
    {:ok, Bevs.list_coffees(args)}
  end

  def get_coffee(_, %{id: id}, _) do
    try do
      {:ok, Bevs.get_coffee!(id)}
    rescue
      _ -> {:error, "No coffee found with id #{id}."}
    end
  end

  def get_average_rating_for_coffees(_, coffee_ids) do
    coffee_ids
    |> Bevs.get_average_rating_for_coffees()
    |> Map.new(fn %{coffee_id: coffee_id, average_rating: average_rating} ->
      {coffee_id, average_rating}
    end)
  end
end
