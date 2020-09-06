defmodule RateCoffee.Bevs do
  @moduledoc """
  The Bevs context.
  """

  import Ecto.Query, warn: false
  alias RateCoffee.Repo

  alias RateCoffee.Bevs.{Coffee, Region, Review, Roaster}

  @doc """
  Returns the list of regions.

  ## Examples

      iex> list_regions()
      [%Region{}, ...]

  """
  def list_regions do
    Repo.all(Region)
  end

  @doc """
  Gets a single region.

  Raises `Ecto.NoResultsError` if the Region does not exist.

  ## Examples

      iex> get_region!(123)
      %Region{}

      iex> get_region!(456)
      ** (Ecto.NoResultsError)

  """
  def get_region!(id), do: Repo.get!(Region, id)

  @doc """
  Creates a region.

  ## Examples

      iex> create_region(%{field: value})
      {:ok, %Region{}}

      iex> create_region(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_region(attrs \\ %{}) do
    %Region{}
    |> Region.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a region.

  ## Examples

      iex> update_region(region, %{field: new_value})
      {:ok, %Region{}}

      iex> update_region(region, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_region(%Region{} = region, attrs) do
    region
    |> Region.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a region.

  ## Examples

      iex> delete_region(region)
      {:ok, %Region{}}

      iex> delete_region(region)
      {:error, %Ecto.Changeset{}}

  """
  def delete_region(%Region{} = region) do
    Repo.delete(region)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking region changes.

  ## Examples

      iex> change_region(region)
      %Ecto.Changeset{data: %Region{}}

  """
  def change_region(%Region{} = region, attrs \\ %{}) do
    Region.changeset(region, attrs)
  end

  @doc """
  Gets a single coffee.

  Raises `Ecto.NoResultsError` if the Coffee does not exist.

  ## Examples

      iex> get_coffee!(123)
      %Region{}

      iex> get_coffee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_coffee!(id) do
    Coffee
    |> with_average_rating()
    |> Repo.get!(id)
    |> parse_average()
  end

  @doc """
  Creates a coffee.

  ## Examples

      iex> create_coffee(%{field: value})
      {:ok, %Coffee{}}

      iex> create_coffee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_coffee(attrs \\ %{}) do
    %Coffee{}
    |> Coffee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a coffee.

  ## Examples

      iex> update_coffee(coffee, %{field: new_value})
      {:ok, %Coffee{}}

      iex> update_coffee(coffee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_coffee(%Coffee{} = coffee, attrs) do
    coffee
    |> Coffee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a coffee.

  ## Examples

      iex> delete_coffee(coffee)
      {:ok, %Coffee{}}

      iex> delete_coffee(coffee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_coffee(%Coffee{} = coffee) do
    Repo.delete(coffee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking coffee changes.

  ## Examples

      iex> change_coffee(coffee)
      %Ecto.Changeset{data: %Coffee{}}

  """
  def change_coffee(%Coffee{} = coffee, attrs \\ %{}) do
    Coffee.changeset(coffee, attrs)
  end

  @doc """
  Creates a roaster.

  ## Examples

      iex> create_roaster(%{field: value})
      {:ok, %Roaster{}}

      iex> create_roaster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roaster(attrs \\ %{}) do
    %Roaster{}
    |> Roaster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns a list of all coffees filtered by name, roaster, and region parameters
  and ordered by an order parameter.
  If no name paramter is given, returns all coffees.
  If no order paramter is given, defaults to ascending order by name.

  ## Examples

      iex> list_coffees(%{name: "reuben"})
      [%Item{name: "Reuben", id: 1}]

      iex> list_coffees(%{})
      [%Item{name: "Reuben", id: 1}, %Item{name: "Cubana", id: 2}]

  """
  def list_coffees(filters) do
    filters
    |> Enum.reduce(Coffee, fn
      {_, nil}, query ->
        query

      {:order, order}, query ->
        query |> order_by({^order, :name})

      {:filter, filter}, query ->
        query |> filter_with(filter)
    end)
    |> with_average_rating()
    |> Repo.all()
    |> Enum.map(&parse_average/1)
  end

  defp parse_average(%{average_rating: average} = coffee) do
    average_rating =
      average
      |> Decimal.round()
      |> Decimal.to_integer()

    %Coffee{coffee | average_rating: average_rating}
  end

  defp with_average_rating(query) do
    avg_query =
      from r in Review,
        group_by: r.coffee_id,
        select: %{coffee_id: r.coffee_id, average_rating: avg(r.rating)}

    from(q in query,
      join: r in subquery(avg_query),
      on: r.coffee_id == q.id,
      select: %{q | average_rating: r.average_rating}
    )
  end

  defp filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:added_after, date}, query ->
        from(q in query, where: q.added_on >= ^date)

      {:added_before, date}, query ->
        from(q in query, where: q.added_on <= ^date)

      {:name, name}, query ->
        from(q in query, where: ilike(q.name, ^"%#{name}%"))

      {:region, region_id}, query ->
        from(q in query, where: q.region_id == ^region_id)

      {:roaster, roaster_id}, query ->
        from(q in query, where: q.roaster_id == ^roaster_id)
    end)
  end
end
