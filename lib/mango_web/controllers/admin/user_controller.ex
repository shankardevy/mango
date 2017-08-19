defmodule MangoWeb.Admin.UserController do
  use MangoWeb, :controller

  alias Mango.Administration

  def index(conn, _params) do
    users = Administration.list_users()
    conn
    |> put_layout("admin_app.html")
    |> render("index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Administration.change_user(%Mango.Administration.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Administration.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: admin_user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Administration.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Administration.get_user!(id)
    changeset = Administration.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Administration.get_user!(id)

    case Administration.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: admin_user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Administration.get_user!(id)
    {:ok, _user} = Administration.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end
end
