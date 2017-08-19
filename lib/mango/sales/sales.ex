defmodule Mango.Sales do
  import Ecto.Query

  alias Mango.Repo
  alias Mango.Sales.Order

  def get_cart(id) do
    Order
    |> Repo.get_by(id: id, status: "In Cart")
  end

  def create_cart do
    %Order{status: "In Cart"}  |> Repo.insert!()
  end

  def add_to_cart(%Order{line_items: []} = cart, cart_params) do
    attrs = %{line_items: [cart_params]}
    update_cart(cart, attrs)
  end

  def add_to_cart(%Order{line_items: existing_line_items} = cart, cart_params) do
    new_item = %{
     product_id: String.to_integer(cart_params["product_id"]),
     quantity: String.to_integer(cart_params["quantity"])
    }
    existing_line_items = existing_line_items |> Enum.map(&Map.from_struct/1)

    attrs = %{line_items: [new_item | existing_line_items]}
    update_cart(cart, attrs)
  end

  def update_cart(cart, attrs) do
    cart
    |> Order.changeset(attrs)
    |> Repo.update
  end

  def change_cart(%Order{} = order) do
    Order.changeset(order, %{})
  end

  def confirm_order(%Order{} = order, attrs) do
    attrs = Map.put(attrs, "status", "Confirmed")
    order
    |> Order.checkout_changeset(attrs)
    |> Repo.update()
  end

  def list_orders do
    Order
    |> where([o], o.status != "In Cart")
    |> Repo.all
  end

  def get_order!(id), do: Repo.get!(Order, id)
end
