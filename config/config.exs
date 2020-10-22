use Mix.Config

config :cog,
  ecto_repos: [Cog.Repo],
  config_prefix: "cog_"

config :cog, CogWeb.Endpoint,
  render_errors: [view: CogWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Cog.PubSub

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
