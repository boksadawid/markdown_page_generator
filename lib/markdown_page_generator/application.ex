defmodule MarkdownPageGenerator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MarkdownPageGeneratorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MarkdownPageGenerator.PubSub},
      # Start the Endpoint (http/https)
      MarkdownPageGeneratorWeb.Endpoint
      # Start a worker by calling: MarkdownPageGenerator.Worker.start_link(arg)
      # {MarkdownPageGenerator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MarkdownPageGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MarkdownPageGeneratorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
