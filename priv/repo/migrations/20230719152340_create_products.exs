defmodule LiveViewMaskingExample.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :amount, :float
      add :title, :string

      timestamps()
    end
  end
end
