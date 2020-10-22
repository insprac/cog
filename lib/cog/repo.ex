defmodule Cog.Repo do
  use Ecto.Repo,
    otp_app: :cog,
    adapter: Ecto.Adapters.Postgres

  def init(_, config) do
    config =
      Keyword.merge(config, [
        username: CogConfig.get!(:repo_username),
        password: CogConfig.get!(:repo_password),
        database: CogConfig.get!(:repo_database),
        hostname: CogConfig.get!(:repo_hostname),
        pool_size: CogConfig.get!(:repo_pool_size)
      ])
    {:ok, config}
  end
end
