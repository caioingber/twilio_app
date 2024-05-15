defmodule TwilioApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TwilioAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:twilio_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TwilioApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TwilioApp.Finch},
      # Start a worker by calling: TwilioApp.Worker.start_link(arg)
      # {TwilioApp.Worker, arg},
      # Start to serve requests, typically the last entry
      TwilioAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwilioApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TwilioAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
