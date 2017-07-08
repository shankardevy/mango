defmodule MangoWeb.Admin.CustomerController do
  use MangoWeb, :controller

  alias Mango.{CRM, Sales}

  def index(conn, _params) do
    customers = CRM.list_customers()
    render(conn, "index.html", customers: customers)
  end

  def show(conn, %{"id" => id}) do
    customer = CRM.get_customer!(id)
    render(conn, "show.html", customer: customer)
  end

end
