defmodule Cog.Repo.Migrations.CreateResourceFieldTable do
  use Ecto.Migration

  def change do
    create table(:resource_fields, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :resource_id, references(:resources, type: :uuid)
      add :name, :string
      add :data_type, :string
      add :metadata, :map
      timestamps inserted_at: :created_at
    end

    create unique_index(:resource_fields, [:resource_id, :name])
  end

end
