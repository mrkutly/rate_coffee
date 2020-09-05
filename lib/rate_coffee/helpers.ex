defmodule RateCoffee.Helpers do
  def put_slug(struct, attrs) do
    slug =
      attrs.name
      |> String.downcase()
      |> String.split()
      |> Enum.join("-")

    Map.put(struct, :slug, slug)
  end
end
