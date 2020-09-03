defmodule RateCoffee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RateCoffee.Repo,
      # Start the Telemetry supervisor
      RateCoffeeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RateCoffee.PubSub},
      # Start the Endpoint (http/https)
      RateCoffeeWeb.Endpoint
      # Start a worker by calling: RateCoffee.Worker.start_link(arg)
      # {RateCoffee.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RateCoffee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RateCoffeeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
