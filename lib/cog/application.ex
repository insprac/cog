defmodule Cog.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Cog.Repo,
      CogWeb.Telemetry,
      {Phoenix.PubSub, name: Cog.PubSub},
      CogWeb.Endpoint,
      Cog.Records.Schemas
    ]

    opts = [strategy: :one_for_one, name: Cog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    CogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
