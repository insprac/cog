defmodule CogWeb.Schema.ResolverHelpers do
  @spec translate_errors({:ok, term} | {:error, term}) ::
          {:ok, term} | {:error, term}
  def translate_errors({:error, %Ecto.Changeset{} = changeset}) do
    field_errors =
      Ecto.Changeset.traverse_errors(changeset, fn {message, options} ->
        Enum.reduce(options, message, fn {key, value}, message ->
          String.replace(message, "%{#{key}}", to_string(value))
        end)
      end)
      |> Map.to_list()
      |> Enum.reduce(%{}, fn {key, errors}, acc ->
        key =
          key
          |> to_string()
          |> Absinthe.Adapter.LanguageConventions.to_external_name(:field)

        Map.put(acc, key, errors)
      end)

    error = %{
      message: "There is an issue with the data provided",
      fieldErrors: field_errors
    }

    {:error, error}
  end

  def translate_errors(result), do: result
end
