defmodule Cog.Resources.Resource do
  use Cog.Schema

  @type t :: %__MODULE__{}

  schema "resources" do
    field :name, :string
    timestamps inserted_at: :created_at
  end

  @spec changeset(t, map) :: Ecto.Changeset.t
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:name])
    |> trim_change(:name)
    |> validate_required(:name)
    |> validate_length(:name, max: 50)
    |> validate_format(:name, ~r/^[a-zA-Z0-9\.]+$/,
      message: "may only contain letter, numbers and dots")
    |> unique_constraint(:name)
  end
end
