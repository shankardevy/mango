defmodule Mango.Sales.LineItem do
  use Ecto.Schema

  embedded_schema do
    field :product_id, :integer
    field :product_name, :string
    field :pack_size, :string
    field :quantity, :integer
    field :unit_price, :decimal
    field :total, :decimal
  end
end
