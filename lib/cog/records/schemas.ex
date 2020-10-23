defmodule Cog.Records.Schemas do
  alias Cog.Resources.Resource

  @type schemas :: %{optional(String.t) => atom}

  @spec start_link(Keyword.t) :: {:ok, pid} | {:error, term}
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec get(Resource.t) :: atom
  def get(%Resource{} = resource) do
    Agent.update(__MODULE__, &get_schema(&1, resource))
  end

  @spec get_schema(schemas, Resource.t) :: {atom, schemas}
  defp get_schema(schemas, resource) do
    if Map.has_key?(schemas, resource.id) do
      {Map.get(schemas, resource.id), schemas}
    else
      if not Cog.Records.Table.exists?(resource) do
        Cog.Records.Table.create(resource)
      end
      schema_name = Cog.Records.Schema.create(resource)
      schemas = Map.put(schemas, resource.id, schema_name)
      {schema_name, schemas}
    end
  end
end
