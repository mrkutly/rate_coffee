# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rate_coffee,
  ecto_repos: [RateCoffee.Repo]

# Configures the endpoint
config :rate_coffee, RateCoffeeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WgMnoWN2RuBv3StM/0BQL433zmAqC9lm9MGajBSB5pn/UEJda3DU/Xup5mNKpMTo",
  render_errors: [view: RateCoffeeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RateCoffee.PubSub,
  live_view: [signing_salt: "0oUdV38l"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
