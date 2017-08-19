defmodule MangoWeb.TicketController do
  use MangoWeb, :controller

  alias Mango.CRM

  def index(conn, _params) do
    tickets = CRM.list_tickets()
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    changeset = CRM.change_ticket(%Mango.CRM.Ticket{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    case CRM.create_ticket(ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = CRM.get_ticket!(id)
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    ticket = CRM.get_ticket!(id)
    changeset = CRM.change_ticket(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = CRM.get_ticket!(id)

    case CRM.update_ticket(ticket, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = CRM.get_ticket!(id)
    {:ok, _ticket} = CRM.delete_ticket(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: ticket_path(conn, :index))
  end
end
