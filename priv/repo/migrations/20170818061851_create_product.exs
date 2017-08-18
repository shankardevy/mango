defmodule Mango.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal
      add :sku, :string
      add :is_seasonal, :boolean, default: false, null: false
      add :image, :string
      add :pack_size, :string
      add :category, :string

      timestamps()
    end

    create unique_index(:products, [:sku])
  end
end
