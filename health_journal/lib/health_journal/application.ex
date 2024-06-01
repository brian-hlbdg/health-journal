defmodule HealthJournal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HealthJournalWeb.Telemetry,
      HealthJournal.Repo,
      {DNSCluster, query: Application.get_env(:health_journal, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HealthJournal.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HealthJournal.Finch},
      # Start a worker by calling: HealthJournal.Worker.start_link(arg)
      # {HealthJournal.Worker, arg},
      # Start to serve requests, typically the last entry
      HealthJournalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HealthJournal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HealthJournalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
