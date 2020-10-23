defmodule Cog.Records do
  alias Cog.Resources.Resource

  @type record :: struct

  @spec get_record(Resource.t(), String.t()) :: record | {:error, :not_found}
  def get_record(%Resource{} = resource, id) do
    Cog.Records.Schemas.get(resource)
    |> Cog.Repo.get(id)
    |> Cog.ContextHelpers.nil_to_error()
  end

  @spec list_records(Resource.t()) :: list(record)
  def list_records(%Resource{} = resource) do
    Cog.Records.Schemas.get(resource)
    |> Cog.Repo.all()
  end

  @spec create_record(Resource.t(), map) ::
          {:ok, record} | {:error, Ecto.Changeset.t()}
  def create_record(%Resource{} = resource, attrs) do
    schema = Cog.Records.Schemas.get(resource)

    struct(schema, %{})
    |> schema.changeset(attrs)
    |> Cog.Repo.insert()
  end

  @spec update_record(Resource.t(), record, map) ::
          {:ok, record} | {:error, Ecto.Changeset.t()}
  def update_record(%Resource{} = resource, %{} = record, attrs) do
    schema = Cog.Records.Schemas.get(resource)

    record
    |> schema.changeset(attrs)
    |> Cog.Repo.update()
  end

  @spec delete_record(record) :: {:ok, record} | {:error, Ecto.Changeset.t()}
  def delete_record(record) when is_struct(record) do
    Cog.Repo.delete(record)
  end
end
