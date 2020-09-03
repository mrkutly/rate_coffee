defmodule RateCoffee.Repo do
  use Ecto.Repo,
    otp_app: :rate_coffee,
    adapter: Ecto.Adapters.Postgres
end
