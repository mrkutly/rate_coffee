defmodule RateCoffee.Helpers do
  import Ecto.Changeset, only: [change: 2]

  def put_slug(struct, %{name: name}) do
    change(struct, slug: slugify(name))
  end

  def slugify(string) do
    string
    |> String.downcase()
    |> String.split()
    |> Enum.join("-")
  end

  def random_byte_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, length)
  end
end
