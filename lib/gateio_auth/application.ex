defmodule GateioAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GateioAuthWeb.Telemetry,
      GateioAuth.Repo,
      {DNSCluster, query: Application.get_env(:gateio_auth, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GateioAuth.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GateioAuth.Finch},
      # Start a worker by calling: GateioAuth.Worker.start_link(arg)
      # {GateioAuth.Worker, arg},
      # Start to serve requests, typically the last entry
      GateioAuthWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GateioAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GateioAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
