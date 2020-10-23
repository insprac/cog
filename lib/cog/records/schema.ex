defmodule Cog.Records.Schema do
  alias Cog.Resources.Resource

  @spec create(Resource.t) :: atom
  def create(%Resource{} = resource) do
    contents = define(resource)
    Module.create(schema_name(resource), contents, Macro.Env.location(__ENV__))
    schema_name(resource)
  end

  @spec define(Resource.t) :: Macro.t
  def define(%Resource{} = resource) do
    quote do
      use Cog.Schema

      @type t :: %__MODULE__{}

      schema unquote(Cog.Records.Table.table_name(resource)) do
        field :data, :map, default: %{}
        timestamps inserted_at: :created_at
      end

      @spec changeset(t, map) :: Ecto.Changeset.t
      def changeset(record, attrs) do
        record
        |> cast(attrs, [:data])
        |> validate_required(:data)
      end
    end
  end

  @spec schema_name(Resource.t) :: atom
  def schema_name(%Resource{} = resource) do
    String.to_atom("Cog.Records.Schema.#{resource.id}")
  end

end
