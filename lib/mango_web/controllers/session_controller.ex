defmodule MangoWeb.SessionController do
  use MangoWeb, :controller
  alias Mango.CRM

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case CRM.get_customer_by_credentials(session_params) do
      :error ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
      customer ->
        path = get_session(conn, :intending_to_visit) || page_path(conn, :index)
        conn
        |> assign(:current_customer, customer)
        |> put_session(:customer_id, customer.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful")
        |> redirect(to: path)
    end
  end

  def delete(conn, _) do
   clear_session(conn)
   |> put_flash(:info, "You have been logged out")
   |> redirect(to: page_path(conn, :index))
  end
end
