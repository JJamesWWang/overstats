defmodule OverStats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OverStatsWeb.Telemetry,
      # Start the Ecto repository
      OverStats.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: OverStats.PubSub},
      # Start Finch
      {Finch, name: OverStats.Finch},
      # Start the Endpoint (http/https)
      OverStatsWeb.Endpoint
      # Start a worker by calling: OverStats.Worker.start_link(arg)
      # {OverStats.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OverStats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OverStatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
