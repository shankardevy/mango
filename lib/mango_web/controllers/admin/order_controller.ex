defmodule MangoWeb.Admin.OrderController do
  use MangoWeb, :controller

  alias Mango.Sales

  def index(conn, _params) do
    orders = Sales.list_orders()
    render(conn, "index.html", orders: orders)
  end

  def show(conn, %{"id" => id}) do
    order = Sales.get_order!(id)
    render(conn, "show.html", order: order)
  end
end
