defmodule Cog.Schema do
  defmacro __using__(_options) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Cog.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
