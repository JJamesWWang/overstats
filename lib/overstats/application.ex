defmodule Overstats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OverstatsWeb.Telemetry,
      # Start the Ecto repository
      Overstats.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Overstats.PubSub},
      # Start Finch
      {Finch, name: Overstats.Finch},
      # Start the Endpoint (http/https)
      OverstatsWeb.Endpoint
      # Start a worker by calling: Overstats.Worker.start_link(arg)
      # {Overstats.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Overstats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OverstatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
