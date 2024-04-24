defmodule AuthPow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuthPowWeb.Telemetry,
      AuthPow.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:auth_pow, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:auth_pow, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AuthPow.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AuthPow.Finch},
      # Start a worker by calling: AuthPow.Worker.start_link(arg)
      # {AuthPow.Worker, arg},
      # Start to serve requests, typically the last entry
      AuthPowWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuthPow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuthPowWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
