defmodule MangoWeb.CartView do
  use MangoWeb, :view
  alias Mango.Sales.Order

  def render("add.json", %{cart: cart, cart_params: cart_params}) do
    %{"product_name" => name, "pack_size" => size, "quantity" => qty } = cart_params

    %{
      message: "Product added to cart - #{name}(#{size}) x #{qty} qty",
      cart_count: cart_count(cart)
     }
  end

  def cart_count(%Plug.Conn{} = conn) do
    cart_count(conn.assigns.cart)
  end

  def cart_count(%Order{} = cart) do
    Enum.reduce(cart.line_items, 0, fn(item, acc) ->
      acc + item.quantity
    end)
  end
end
