defmodule Cog.Records.Schema do
  alias Cog.Resources.Resource

  def define(%Resource{} = resource) do
    schema_name = String.to_atom("Cog.Records.Schema.#{resource.name}")
    contents =
      quote do
        use Cog.Schema

        @type t :: %__MODULE__{}

        schema unquote(schema_name) do
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
    Module.create(schema_name, contents, Macro.Env.location(__ENV__))
  end

  def create_table(%Resource{} = resource) do
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

  def table_exists?(%Resource{} = resource) do
    query =
      """
      SELECT table_name FROM information_schema.tables
      WHERE table_schema = 'public' AND table_name = '#{table_name(resource)}';
      """
    %Postgrex.Result{rows: rows} = Ecto.Adapters.SQL.query!(Cog.Repo, query, [])
    length(rows) > 0
  end

  def table_name(%Resource{id: id}), do: "records.#{id}"

end
