defmodule Cog.Factory do
  @callback attrs() :: map
  @callback attrs(map | Keyword.t) :: map
  @callback bad_attrs() :: map
  @callback bad_attrs(map | Keyword.t) :: map
  @callback create() :: map
  @callback create(map | Keyword.t) :: struct

  defmacro __using__(_options) do
    quote do
      import Cog.Factory

      @behaviour Cog.Factory

      @impl true
      def attrs, do: attrs(%{})

      @impl true
      def attrs(given) when is_list(given) do
        keyword_to_map(given)
        |> attrs()
      end

      @impl true
      def bad_attrs, do: bad_attrs(%{})

      @impl true
      def bad_attrs(given) when is_list(given) do
        keyword_to_map(given)
        |> bad_attrs()
      end

      @impl true
      def create, do: create(%{})

      @impl true
      def create(given) when is_list(given) do
        keyword_to_map(given)
        |> create()
      end

    end

  end

  @spec keyword_to_map(Keyword.t) :: map
  def keyword_to_map(keyword) do
    Enum.reduce(keyword, %{}, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end

  @spec id() :: integer
  def id, do: System.unique_integer([:positive])
end
