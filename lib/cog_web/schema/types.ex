defmodule CogWeb.Schema.Types do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias CogWeb.Schema.Resolvers

  scalar :datetime do
    parse(fn
      %{value: value} when is_binary(value) and value != "" ->
        with {:error, _error} <- NaiveDateTime.from_iso8601(value) do
          {:error, "Invalid format, must be an ISO 8601 string."}
        end

      _ ->
        {:ok, nil}
    end)

    serialize(fn naive_datetime ->
      NaiveDateTime.to_iso8601(naive_datetime) <> "Z"
    end)
  end

  scalar :json do
    parse(fn
      %{value: value} when is_binary(value) and value != "" ->
        with {:error, _error} <- Jason.decode(value) do
          {:error, "Invalid format, must be valid JSON"}
        end

      _ ->
        {:ok, nil}
    end)

    serialize(fn object ->
      Jason.encode!(object)
    end)
  end

  object :resource do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :created_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)

    field :fields, non_null(list_of(:resource_field)) do
      resolve(dataloader(Cog.Query))
    end
  end

  object :resource_field do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :data_type, non_null(:string)
    field :metadata, non_null(:json)
    field :created_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :resource, non_null(:resource), resolve: dataloader(Cog.Query)
  end

  object :record do
    field :id, non_null(:id)
    field :data, non_null(:json)
    field :created_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  input_object :resource_input do
    field :name, non_null(:string)
  end

  input_object :resource_field_input do
    field :name, non_null(:string)
    field :data_type, non_null(:string)
    field :metadata, :json
    field :resource_id, :json
  end

  input_object :record_input do
    field :data, non_null(:json)
  end
end
