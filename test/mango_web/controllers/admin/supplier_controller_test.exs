defmodule MangoWeb.Admin.SupplierControllerTest do
  use MangoWeb.ConnCase

  alias Mango.Warehouse

  @create_attrs %{contact_person: "some contact_person", email: "some email", name: "some name", phone: "some phone"}
  @update_attrs %{contact_person: "some updated contact_person", email: "some updated email", name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{contact_person: nil, email: nil, name: nil, phone: nil}

  def fixture(:supplier) do
    {:ok, supplier} = Warehouse.create_supplier(@create_attrs)
    supplier
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_supplier_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Suppliers"
  end

  test "renders form for new suppliers", %{conn: conn} do
    conn = get conn, admin_supplier_path(conn, :new)
    assert html_response(conn, 200) =~ "New Supplier"
  end

  test "creates supplier and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, admin_supplier_path(conn, :create), supplier: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == admin_supplier_path(conn, :show, id)

    conn = get conn, admin_supplier_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Supplier"
  end

  test "does not create supplier and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_supplier_path(conn, :create), supplier: @invalid_attrs
    assert html_response(conn, 200) =~ "New Supplier"
  end

  test "renders form for editing chosen supplier", %{conn: conn} do
    supplier = fixture(:supplier)
    conn = get conn, admin_supplier_path(conn, :edit, supplier)
    assert html_response(conn, 200) =~ "Edit Supplier"
  end

  test "updates chosen supplier and redirects when data is valid", %{conn: conn} do
    supplier = fixture(:supplier)
    conn = put conn, admin_supplier_path(conn, :update, supplier), supplier: @update_attrs
    assert redirected_to(conn) == admin_supplier_path(conn, :show, supplier)

    conn = get conn, admin_supplier_path(conn, :show, supplier)
    assert html_response(conn, 200) =~ "some updated contact_person"
  end

  test "does not update chosen supplier and renders errors when data is invalid", %{conn: conn} do
    supplier = fixture(:supplier)
    conn = put conn, admin_supplier_path(conn, :update, supplier), supplier: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Supplier"
  end

  test "deletes chosen supplier", %{conn: conn} do
    supplier = fixture(:supplier)
    conn = delete conn, admin_supplier_path(conn, :delete, supplier)
    assert redirected_to(conn) == admin_supplier_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, admin_supplier_path(conn, :show, supplier)
    end
  end
end
