defmodule LiveViewMaskingExample.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias LiveViewMaskingExample.Repo

  alias LiveViewMaskingExample.Catalog.Poduct

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Poduct{}, ...]

  """
  def list_products do
    Repo.all(Poduct)
  end

  @doc """
  Gets a single poduct.

  Raises `Ecto.NoResultsError` if the Poduct does not exist.

  ## Examples

      iex> get_poduct!(123)
      %Poduct{}

      iex> get_poduct!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poduct!(id), do: Repo.get!(Poduct, id)

  @doc """
  Creates a poduct.

  ## Examples

      iex> create_poduct(%{field: value})
      {:ok, %Poduct{}}

      iex> create_poduct(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poduct(attrs \\ %{}) do
    %Poduct{}
    |> Poduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poduct.

  ## Examples

      iex> update_poduct(poduct, %{field: new_value})
      {:ok, %Poduct{}}

      iex> update_poduct(poduct, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poduct(%Poduct{} = poduct, attrs) do
    poduct
    |> Poduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poduct.

  ## Examples

      iex> delete_poduct(poduct)
      {:ok, %Poduct{}}

      iex> delete_poduct(poduct)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poduct(%Poduct{} = poduct) do
    Repo.delete(poduct)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poduct changes.

  ## Examples

      iex> change_poduct(poduct)
      %Ecto.Changeset{data: %Poduct{}}

  """
  def change_poduct(%Poduct{} = poduct, attrs \\ %{}) do
    Poduct.changeset(poduct, attrs)
  end
end
