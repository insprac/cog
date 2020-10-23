defmodule Cog.ResourceFactory do
  use Cog.Factory

  @impl true
  def attrs(%{} = attrs) do
    %{name: "TestResource.#{id()}"}
    |> Map.merge(attrs)
  end

  @impl true
  def bad_attrs(%{} = attrs) do
    %{name: "Bad Name!"}
    |> Map.merge(attrs)
  end

  @impl true
  def create(%{} = attrs) do
    {:ok, resource} =
      attrs(attrs)
      |> Cog.Resources.create_resource()
    resource
  end
end
