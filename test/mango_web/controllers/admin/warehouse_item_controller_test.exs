defmodule MangoWeb.Admin.WarehouseItemControllerTest do
  use MangoWeb.ConnCase

  alias Mango.Warehouse

  @create_attrs %{price: "120.5", sku: "some sku", stock_quantity: 42}
  @update_attrs %{price: "456.7", sku: "some updated sku", stock_quantity: 43}
  @invalid_attrs %{price: nil, sku: nil, stock_quantity: nil}

  def fixture(:warehouse_item) do
    {:ok, warehouse_item} = Warehouse.create_warehouse_item(@create_attrs)
    warehouse_item
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_warehouse_item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Warehouse items"
  end

  test "renders form for new warehouse_items", %{conn: conn} do
    conn = get conn, admin_warehouse_item_path(conn, :new)
    assert html_response(conn, 200) =~ "New Ware house item"
  end

  test "creates warehouse_item and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, admin_warehouse_item_path(conn, :create), warehouse_item: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == admin_warehouse_item_path(conn, :show, id)

    conn = get conn, admin_warehouse_item_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Ware house item"
  end

  test "does not create warehouse_item and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_warehouse_item_path(conn, :create), warehouse_item: @invalid_attrs
    assert html_response(conn, 200) =~ "New Ware house item"
  end

  test "renders form for editing chosen warehouse_item", %{conn: conn} do
    warehouse_item = fixture(:warehouse_item)
    conn = get conn, admin_warehouse_item_path(conn, :edit, warehouse_item)
    assert html_response(conn, 200) =~ "Edit Ware house item"
  end

  test "updates chosen warehouse_item and redirects when data is valid", %{conn: conn} do
    warehouse_item = fixture(:warehouse_item)
    conn = put conn, admin_warehouse_item_path(conn, :update, warehouse_item), warehouse_item: @update_attrs
    assert redirected_to(conn) == admin_warehouse_item_path(conn, :show, warehouse_item)

    conn = get conn, admin_warehouse_item_path(conn, :show, warehouse_item)
    assert html_response(conn, 200) =~ "some updated sku"
  end

  test "does not update chosen warehouse_item and renders errors when data is invalid", %{conn: conn} do
    warehouse_item = fixture(:warehouse_item)
    conn = put conn, admin_warehouse_item_path(conn, :update, warehouse_item), warehouse_item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Ware house item"
  end

  test "deletes chosen warehouse_item", %{conn: conn} do
    warehouse_item = fixture(:warehouse_item)
    conn = delete conn, admin_warehouse_item_path(conn, :delete, warehouse_item)
    assert redirected_to(conn) == admin_warehouse_item_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, admin_warehouse_item_path(conn, :show, warehouse_item)
    end
  end
end
