defmodule Mango.Repo.Migrations.CreateWarehouseItems do
  use Ecto.Migration

  def change do
    create table(:warehouse_items) do
      add :sku, :string
      add :price, :decimal
      add :stock_quantity, :integer

      timestamps()
    end

  end
end
