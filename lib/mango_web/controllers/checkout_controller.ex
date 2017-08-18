defmodule MangoWeb.CheckoutController do
  use MangoWeb, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end
end
