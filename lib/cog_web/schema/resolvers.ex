defmodule CogWeb.Schema.Resolvers do
  import CogWeb.Schema.ResolverHelpers

  alias Cog.Resources.{Resource, ResourceField}

  def list_resources(_, _args, _) do
    {:ok, Cog.Resources.list_resources()}
  end

  def get_resource(_, %{id: id}, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(id) do
      {:ok, resource}
    end
  end

  def create_resource(_, args, _) do
    Cog.Resources.create_resource(args.input)
    |> translate_errors()
  end

  def update_resource(_, %{id: id} = args, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(id) do
      Cog.Resources.update_resource(resource, args.input)
      |> translate_errors()
    end
  end

  def list_records(_, %{resource_id: resource_id}, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(resource_id) do
      IO.inspect("LISTING RECORDS")
      {:ok, Cog.Records.list_records(resource)}
    end
  end

  def get_record(_, %{resource_id: resource_id, id: id}, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(resource_id) do
      with %{} = record <- Cog.Records.get_record(resource, id) do
        {:ok, record}
      end
    end
  end

  def create_record(_, %{resource_id: resource_id} = args, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(resource_id) do
      Cog.Records.create_record(resource, args.input)
      |> translate_errors()
    end
  end

  def update_record(_, %{resource_id: resource_id, id: id} = args, _) do
    with %Resource{} = resource <- Cog.Resources.get_resource(resource_id) do
      with record when record != nil <- Cog.Records.get_record(resource, id) do
        Cog.Records.update_record(resource, record, args.input)
        |> translate_errors()
      end
    end
  end
end
