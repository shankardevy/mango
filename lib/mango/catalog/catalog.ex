defmodule Mango.Catalog do
  alias Mango.Catalog.Product

  def list_products do
    product1 = %Product{ name: "Tomato", price: 50, is_seasonal: false, category: "vegetables" }
    product2 = %Product{ name: "Apple", price: 100, is_seasonal: true, category: "fruits" }
    [product1, product2]
  end

  def list_seasonal_products do
    list_products()
    |> Enum.filter(fn(product) -> product.is_seasonal == true end)
  end

  def get_category_products(name) do
    list_products()
    |> Enum.filter(fn(product) -> product.category == name end)
  end
end
