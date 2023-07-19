defmodule LiveViewMaskingExample.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewMaskingExample.Catalog` context.
  """

  @doc """
  Generate a poduct.
  """
  def poduct_fixture(attrs \\ %{}) do
    {:ok, poduct} =
      attrs
      |> Enum.into(%{
        title: "some title",
        amount: 120.5
      })
      |> LiveViewMaskingExample.Catalog.create_poduct()

    poduct
  end
end
