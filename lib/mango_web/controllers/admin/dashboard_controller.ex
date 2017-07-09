defmodule MangoWeb.Admin.DashboardController do
  use MangoWeb, :controller

  def show(conn, _params) do
    render conn, "show.html"
  end
end
