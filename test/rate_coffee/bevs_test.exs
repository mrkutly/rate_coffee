defmodule RateCoffee.BevsTest do
  use RateCoffee.DataCase

  alias RateCoffee.Bevs

  describe "regions" do
    alias RateCoffee.Bevs.Region

    @valid_attrs %{country: "some country", name: "some name"}
    @update_attrs %{country: "some updated country", name: "some updated name"}
    @invalid_attrs %{country: nil, name: nil}

    def region_fixture(attrs \\ %{}) do
      {:ok, region} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bevs.create_region()

      region
    end

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Bevs.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Bevs.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      assert {:ok, %Region{} = region} = Bevs.create_region(@valid_attrs)
      assert region.country == "some country"
      assert region.name == "some name"
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bevs.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      assert {:ok, %Region{} = region} = Bevs.update_region(region, @update_attrs)
      assert region.country == "some updated country"
      assert region.name == "some updated name"
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Bevs.update_region(region, @invalid_attrs)
      assert region == Bevs.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Bevs.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Bevs.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Bevs.change_region(region)
    end
  end
end
