defmodule Latency.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LatencyWeb.Telemetry,
      Latency.Repo,
      {DNSCluster, query: Application.get_env(:latency, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Latency.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Latency.Finch},
      # Start a worker by calling: Latency.Worker.start_link(arg)
      # {Latency.Worker, arg},
      # Start to serve requests, typically the last entry
      LatencyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Latency.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LatencyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
