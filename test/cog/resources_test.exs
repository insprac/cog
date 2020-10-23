defmodule Cog.ResourcesTest do
  use Cog.DataCase

  alias Cog.{Resources, ResourceFactory}
  alias Cog.Resources.Resource

  describe "create_resource/1" do
    test "creates a valid resource" do
      attrs = ResourceFactory.attrs()
      assert {:ok, %Resource{} = resource} = Resources.create_resource(attrs)
      assert is_binary(resource.id)
      assert resource.name == attrs.name
    end

    test "fails with bad attrs" do
      bad_attrs = ResourceFactory.bad_attrs()
      assert {:error, %Ecto.Changeset{}} = Resources.create_resource(bad_attrs)
    end
  end

  describe "update_resource/1" do
    test "updates the given resource" do
      original_resource = ResourceFactory.create()
      attrs = ResourceFactory.attrs()
      assert {:ok, %Resource{} = resource} =
        Resources.update_resource(original_resource, attrs)
      assert resource.name == attrs.name
    end

    test "fails with bad attrs" do
      original_resource = ResourceFactory.create()
      bad_attrs = ResourceFactory.bad_attrs()
      assert {:error, %Ecto.Changeset{}} =
        Resources.update_resource(original_resource, bad_attrs)
    end
  end
end
