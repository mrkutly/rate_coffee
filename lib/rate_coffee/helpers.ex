defmodule RateCoffee.Helpers do
  import Ecto.Changeset, only: [change: 2]

  def put_slug(struct, attrs) do
    slug =
      attrs.name
      |> String.downcase()
      |> String.split()
      |> Enum.join("-")

    change(struct, slug: slug)
  end

  def random_byte_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, length)
  end
end
