defmodule Cog.Resources.ResourceField do
  use Cog.Schema

  @type t :: %__MODULE__{}

  @data_types ~w(string float integer boolean)

  schema "resource_fields" do
    field :name, :string
    field :data_type, :string
    field :metadata, :map, default: %{}
    belongs_to :resource, Cog.Resources.Resource
    timestamps inserted_at: :created_at
  end

  @spec creation_changeset(map) :: Ecto.Changeset.t
  def creation_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:resource_id])
    |> validate_required(:resource_id)
    |> assoc_constraint(:resource)
    |> changeset(attrs)
  end

  @spec changeset(t | Ecto.Changeset.t, map) :: Ecto.Changeset.t
  def changeset(resource_field, attrs) do
    resource_field
    |> cast(attrs, [:name, :data_type, :metadata])
    |> trim_change([:name, :data_type])
    |> validate_inclusion(:data_type, @data_types)
    |> validate_required([:name, :data_type, :metadata])
    |> validate_length(:name, max: 50)
    |> validate_format(:name, ~r/^[a-zA-Z0-9\.]+$/,
      message: "may only contain letter, numbers and dots")
    |> unique_constraint(:name, name: :resource_fields_resource_id_name_index)
  end

end
