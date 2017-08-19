defmodule MangoWeb.Admin.DashboardController do
  use MangoWeb, :controller

  def show(conn, _params) do
    admin = conn.assigns.current_admin
    token = Phoenix.Token.sign(conn, "socket_login", admin.id)
    render conn, "show.html", token: token
  end
end
