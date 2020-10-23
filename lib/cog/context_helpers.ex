defmodule Cog.ContextHelpers do
  @spec nil_to_error(struct | nil) :: struct | {:error, :not_found}
  def nil_to_error(nil), do: {:error, :not_found}
  def nil_to_error(struct) when is_struct(struct), do: struct
end
