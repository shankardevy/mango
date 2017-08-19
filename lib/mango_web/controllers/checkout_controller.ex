defmodule MangoWeb.CheckoutController do
  use MangoWeb, :controller
  alias Mango.Sales

  def edit(conn, _params) do
    order = conn.assigns.cart
    order_changeset = Sales.change_cart(order)
    render conn, "edit.html",
           order: order,
           order_changeset: order_changeset
  end

  def update(conn, %{"order" => order_params}) do
    order = conn.assigns.cart
    order_params = associate_user_from_session(conn, order_params)
    case Sales.confirm_order(order, order_params) do
      {:ok, order} ->
        message = "New Order ##{order.id} from #{order.customer_name}"
        MangoWeb.Endpoint.broadcast! "pos", "message:new", %{message: message}
        conn
        |> put_flash(:info, "Your order has been confirmed.")
        |> redirect(to: "/")
      {:error, order_changeset} ->
        render conn, "edit.html", order: order, order_changeset: order_changeset
    end
  end

  def associate_user_from_session(conn, params) do
    customer = conn.assigns.current_customer
    params
    |> Map.put("customer_id", customer.id)
    |> Map.put("customer_name", customer.name)
    |> Map.put("residence_area", customer.residence_area)
    |> Map.put("email", customer.email)
  end
end
