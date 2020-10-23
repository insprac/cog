defmodule Cog.Resources do
  alias Cog.Resources.{Resource, ResourceField}

  @spec get_resource(integer) :: Resource.t() | {:error, :not_found}
  def get_resource(id) do
    Cog.Repo.get(Resource, id)
    |> Cog.ContextHelpers.nil_to_error()
  end

  @spec list_resources() :: list(Resource)
  def list_resources, do: Cog.Repo.all(Resource)

  @spec create_resource(map) ::
          {:ok, Resource.t()} | {:error, Ecto.Changeset.t()}
  def create_resource(attrs) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Cog.Repo.insert()
  end

  @spec update_resource(Resource.t(), map) ::
          {:ok, Resource.t()} | {:error, Ecto.Changeset.t()}
  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Cog.Repo.update()
  end

  @spec delete_resource(Resource.t()) ::
          {:ok, Resource.t()} | {:error, Ecto.Changeset.t()}
  def delete_resource(%Resource{} = resource), do: Cog.Repo.delete(resource)

  @spec get_field(integer) :: ResourceField.t() | {:error, :not_found}
  def get_field(id) do
    Cog.Repo.get(ResourceField, id)
    |> Cog.ContextHelpers.nil_to_error()
  end

  @spec list_fields() :: list(ResourceField)
  def list_fields, do: Cog.Repo.all(ResourceField)

  @spec create_field(map) ::
          {:ok, ResourceField.t()} | {:error, Ecto.Changeset.t()}
  def create_field(attrs) do
    ResourceField.creation_changeset(attrs)
    |> Cog.Repo.insert()
  end

  @spec update_field(ResourceField.t(), map) ::
          {:ok, ResourceField.t()} | {:error, Ecto.Changeset.t()}
  def update_field(%ResourceField{} = field, attrs) do
    field
    |> ResourceField.changeset(attrs)
    |> Cog.Repo.update()
  end

  @spec delete_field(ResourceField.t()) ::
          {:ok, ResourceField.t()} | {:error, Ecto.Changeset.t()}
  def delete_field(%ResourceField{} = field), do: Cog.Repo.delete(field)
end
