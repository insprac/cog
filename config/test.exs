use Mix.Config

config :cog,
  config_prefix: "cog_test_"

config :cog, Cog.Repo,
  pool: Ecto.Adapters.SQL.Sandbox

config :cog, CogWeb.Endpoint,
  server: false

config :logger, level: :warn
