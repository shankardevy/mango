defmodule MangoWeb.PageController do
  use MangoWeb, :controller
  alias Mango.Catalog

  def index(conn, _params) do
    seasonal_products = Catalog.list_seasonal_products

    render conn, "index.html", seasonal_products: seasonal_products
  end
end
