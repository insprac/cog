use Mix.Config

config :cog, Cog.Repo,
  show_sensitive_data_on_connection_error: true

config :cog, CogWeb.Endpoint,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
