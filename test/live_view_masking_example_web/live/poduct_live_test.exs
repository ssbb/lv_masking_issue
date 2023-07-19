defmodule LiveViewMaskingExampleWeb.PoductLiveTest do
  use LiveViewMaskingExampleWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveViewMaskingExample.CatalogFixtures

  @create_attrs %{title: "some title", amount: 120.5}
  @update_attrs %{title: "some updated title", amount: 456.7}
  @invalid_attrs %{title: nil, amount: nil}

  defp create_poduct(_) do
    poduct = poduct_fixture()
    %{poduct: poduct}
  end

  describe "Index" do
    setup [:create_poduct]

    test "lists all products", %{conn: conn, poduct: poduct} do
      {:ok, _index_live, html} = live(conn, ~p"/products")

      assert html =~ "Listing Products"
      assert html =~ poduct.title
    end

    test "saves new poduct", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/products")

      assert index_live |> element("a", "New Poduct") |> render_click() =~
               "New Poduct"

      assert_patch(index_live, ~p"/products/new")

      assert index_live
             |> form("#poduct-form", poduct: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#poduct-form", poduct: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/products")

      html = render(index_live)
      assert html =~ "Poduct created successfully"
      assert html =~ "some title"
    end

    test "updates poduct in listing", %{conn: conn, poduct: poduct} do
      {:ok, index_live, _html} = live(conn, ~p"/products")

      assert index_live |> element("#products-#{poduct.id} a", "Edit") |> render_click() =~
               "Edit Poduct"

      assert_patch(index_live, ~p"/products/#{poduct}/edit")

      assert index_live
             |> form("#poduct-form", poduct: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#poduct-form", poduct: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/products")

      html = render(index_live)
      assert html =~ "Poduct updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes poduct in listing", %{conn: conn, poduct: poduct} do
      {:ok, index_live, _html} = live(conn, ~p"/products")

      assert index_live |> element("#products-#{poduct.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#products-#{poduct.id}")
    end
  end

  describe "Show" do
    setup [:create_poduct]

    test "displays poduct", %{conn: conn, poduct: poduct} do
      {:ok, _show_live, html} = live(conn, ~p"/products/#{poduct}")

      assert html =~ "Show Poduct"
      assert html =~ poduct.title
    end

    test "updates poduct within modal", %{conn: conn, poduct: poduct} do
      {:ok, show_live, _html} = live(conn, ~p"/products/#{poduct}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Poduct"

      assert_patch(show_live, ~p"/products/#{poduct}/show/edit")

      assert show_live
             |> form("#poduct-form", poduct: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#poduct-form", poduct: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/products/#{poduct}")

      html = render(show_live)
      assert html =~ "Poduct updated successfully"
      assert html =~ "some updated title"
    end
  end
end
