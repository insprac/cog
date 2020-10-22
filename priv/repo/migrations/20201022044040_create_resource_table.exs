defmodule Cog.Repo.Migrations.CreateResourceTable do
  use Ecto.Migration

  def change do
    create table(:resources, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      timestamps inserted_at: :created_at
    end

    create unique_index(:resources, [:name])
  end
end
