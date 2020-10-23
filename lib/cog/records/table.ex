defmodule Cog.Records.Table do
  alias Cog.Resources.Resource

  @spec create(Resource.t) :: :ok
  def create(%Resource{} = resource) do
    query =
      """
      CREATE TABLE "#{table_name(resource)}" (
        id uuid NOT NULL,
        data jsonb,
        created_at timestamp(0) without time zone NOT NULL,
        updated_at timestamp(0) without time zone NOT NULL
      );
      """
    Ecto.Adapters.SQL.query!(Cog.Repo, query, [])
    :ok
  end

  @spec exists?(Resource.t) :: boolean
  def exists?(%Resource{} = resource) do
    query =
      """
      SELECT table_name FROM information_schema.tables
      WHERE table_schema = 'public' AND table_name = '#{table_name(resource)}';
      """
    %Postgrex.Result{rows: rows} = Ecto.Adapters.SQL.query!(Cog.Repo, query, [])
    length(rows) > 0
  end

  @spec table_name(Resource.t) :: String.t
  def table_name(%Resource{id: id}), do: "records.#{id}"

end
