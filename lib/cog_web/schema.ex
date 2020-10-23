defmodule CogWeb.Schema do
  use Absinthe.Schema
  import_types(CogWeb.Schema.Types)

  alias CogWeb.Schema.Resolvers

  query do
    field :resources, list_of(:resource) do
      resolve(&Resolvers.list_resources/3)
    end

    field :resource, :resource do
      arg(:id, non_null(:id))
      resolve(&Resolvers.get_resource/3)
    end

    field :records, list_of(:record) do
      arg(:resource_id, non_null(:id))
      resolve(&Resolvers.list_records/3)
    end

    field :record, :record do
      arg(:resource_id, non_null(:id))
      arg(:id, non_null(:id))
      resolve(&Resolvers.get_record/3)
    end
  end

  mutation do
    field :create_resource, :resource do
      arg(:input, non_null(:resource_input))
      resolve(&Resolvers.create_resource/3)
    end

    field :create_resource_field, :resource_field do
      arg(:input, non_null(:resource_field_input))
      resolve(&Resolvers.create_resource_field/3)
    end

    field :update_resource, :resource do
      arg(:id, non_null(:id))
      arg(:input, non_null(:resource_input))
      resolve(&Resolvers.update_resource/3)
    end

    field :update_resource_field, :resource_field do
      arg(:id, non_null(:id))
      arg(:input, non_null(:resource_field_input))
      resolve(&Resolvers.update_resource_field/3)
    end

    field :create_record, :record do
      arg(:resource_id, non_null(:id))
      arg(:input, non_null(:record_input))
      resolve(&Resolvers.create_record/3)
    end

    field :update_record, :record do
      arg(:resource_id, non_null(:id))
      arg(:id, non_null(:id))
      arg(:input, non_null(:record_input))
      resolve(&Resolvers.update_record/3)
    end
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Cog.Query, Cog.Query.data())

    Map.put(context, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
