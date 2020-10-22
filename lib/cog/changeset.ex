defmodule Cog.Changeset do
  @spec trim_change(Ecto.Changeset.t, list(atom)) :: Ecto.Changeset.t
  def trim_change(changeset, []), do: changeset
  def trim_change(changeset, [field_name | tail]) do
    changeset
    |> trim_change(field_name)
    |> trim_change(tail)
  end

  @spec trim_change(Ecto.Changeset.t, atom) :: Ecto.Changeset.t
  def trim_change(changeset, field_name) do
    Ecto.Changeset.update_change(changeset, field_name, fn
      value when is_binary(value) -> String.trim(value)
      value -> value
    end)
  end

  @spec downcase_change(Ecto.Changeset.t, list(atom)) :: Ecto.Changeset.t
  def downcase_change(changeset, []), do: changeset
  def downcase_change(changeset, [field_name | tail]) do
    changeset
    |> downcase_change(field_name)
    |> downcase_change(tail)
  end

  @spec downcase_change(Ecto.Changeset.t, atom) :: Ecto.Changeset.t
  def downcase_change(changeset, field_name) when is_atom(field_name) do
    Ecto.Changeset.update_change(changeset, field_name, fn
      value when is_binary(value) -> String.downcase(value)
      value -> value
    end)
  end

  @spec validate_list_inclusion(Ecto.Changeset.t, atom, list(term))
  :: Ecto.Changeset.t
  def validate_list_inclusion(changeset, field_name, allowed_items) do
    Ecto.Changeset.validate_change(changeset, field_name, fn
      _field_name, list_value when is_list(list_value) ->
        Enum.reduce(list_value, [], fn value, errors ->
          if value in allowed_items do
            errors
          else
            items = Enum.join(allowed_items, ", ")
            message = "#{value} isn't allowed, may only contain: #{items}"
            errors ++ [{field_name, message}]
          end
        end)
      _field_name, _value ->
        []
    end)
  end
end
