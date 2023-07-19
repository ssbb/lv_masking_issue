defmodule LiveViewMaskingExample.Catalog.Poduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :title, :string
    field :amount, :float

    timestamps()
  end

  @doc false
  def changeset(poduct, attrs) do
    poduct
    |> cast(attrs, [:amount, :title])
    |> validate_required([:amount, :title])
    |> update_change(:title, &String.downcase/1)
  end
end
