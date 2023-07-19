defmodule LiveViewMaskingExample.CatalogTest do
  use LiveViewMaskingExample.DataCase

  alias LiveViewMaskingExample.Catalog

  describe "products" do
    alias LiveViewMaskingExample.Catalog.Poduct

    import LiveViewMaskingExample.CatalogFixtures

    @invalid_attrs %{title: nil, amount: nil}

    test "list_products/0 returns all products" do
      poduct = poduct_fixture()
      assert Catalog.list_products() == [poduct]
    end

    test "get_poduct!/1 returns the poduct with given id" do
      poduct = poduct_fixture()
      assert Catalog.get_poduct!(poduct.id) == poduct
    end

    test "create_poduct/1 with valid data creates a poduct" do
      valid_attrs = %{title: "some title", amount: 120.5}

      assert {:ok, %Poduct{} = poduct} = Catalog.create_poduct(valid_attrs)
      assert poduct.title == "some title"
      assert poduct.amount == 120.5
    end

    test "create_poduct/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_poduct(@invalid_attrs)
    end

    test "update_poduct/2 with valid data updates the poduct" do
      poduct = poduct_fixture()
      update_attrs = %{title: "some updated title", amount: 456.7}

      assert {:ok, %Poduct{} = poduct} = Catalog.update_poduct(poduct, update_attrs)
      assert poduct.title == "some updated title"
      assert poduct.amount == 456.7
    end

    test "update_poduct/2 with invalid data returns error changeset" do
      poduct = poduct_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_poduct(poduct, @invalid_attrs)
      assert poduct == Catalog.get_poduct!(poduct.id)
    end

    test "delete_poduct/1 deletes the poduct" do
      poduct = poduct_fixture()
      assert {:ok, %Poduct{}} = Catalog.delete_poduct(poduct)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_poduct!(poduct.id) end
    end

    test "change_poduct/1 returns a poduct changeset" do
      poduct = poduct_fixture()
      assert %Ecto.Changeset{} = Catalog.change_poduct(poduct)
    end
  end
end
