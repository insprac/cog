defmodule CogConfig do
  import Cony

  @prefix Application.get_env(:cog, :config_prefix) || "cog_"

  config env_prefix: @prefix do
    add :repo_username, :string
    add :repo_password, :string
    add :repo_database, :string
    add :repo_hostname, :string
    add :repo_pool_size, :integer

    add :web_host, :string
    add :web_port, :integer
    add :web_secret_key_base, :string
  end
end
