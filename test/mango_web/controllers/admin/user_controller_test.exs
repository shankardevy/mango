defmodule MangoWeb.Admin.UserControllerTest do
  use MangoWeb.ConnCase

  alias Mango.Administration

  @create_attrs %{email: "some email", name: "some name", phone: "some phone"}
  @update_attrs %{email: "some updated email", name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{email: nil, name: nil, phone: nil}

  def fixture(:user) do
    {:ok, user} = Administration.create_user(@create_attrs)
    user
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Users"
  end

  test "renders form for new users", %{conn: conn} do
    conn = get conn, admin_user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  test "creates user and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, admin_user_path(conn, :create), user: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == admin_user_path(conn, :show, id)

    conn = get conn, admin_user_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show User"
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New User"
  end

  test "renders form for editing chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = get conn, admin_user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit User"
  end

  test "updates chosen user and redirects when data is valid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, admin_user_path(conn, :update, user), user: @update_attrs
    assert redirected_to(conn) == admin_user_path(conn, :show, user)

    conn = get conn, admin_user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "some updated email"
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, admin_user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit User"
  end

  test "deletes chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = delete conn, admin_user_path(conn, :delete, user)
    assert redirected_to(conn) == admin_user_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, admin_user_path(conn, :show, user)
    end
  end
end
