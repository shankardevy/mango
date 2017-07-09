defmodule Mango.Warehouse.WarehouseItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.Warehouse.WarehouseItem


  schema "warehouse_items" do
    field :price, :decimal
    field :sku, :string
    field :stock_quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(%WarehouseItem{} = warehouse_item, attrs) do
    warehouse_item
    |> cast(attrs, [:sku, :price, :stock_quantity])
    |> validate_required([:sku, :price, :stock_quantity])
  end
end
