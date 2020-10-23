defmodule Cog.Query do
  def data do
    Dataloader.Ecto.new(Cog.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
