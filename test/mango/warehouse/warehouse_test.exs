defmodule Mango.WarehouseTest do
  use Mango.DataCase

  alias Mango.Warehouse

  describe "warehouse_items" do
    alias Mango.Warehouse.WarehouseItem

    @valid_attrs %{price: "120.5", sku: "some sku", stock_quantity: 42}
    @update_attrs %{price: "456.7", sku: "some updated sku", stock_quantity: 43}
    @invalid_attrs %{price: nil, sku: nil, stock_quantity: nil}

    def warehouse_item_fixture(attrs \\ %{}) do
      {:ok, warehouse_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Warehouse.create_warehouse_item()

      warehouse_item
    end

    test "list_warehouse_items/0 returns all warehouse_items" do
      warehouse_item = warehouse_item_fixture()
      assert Warehouse.list_warehouse_items() == [warehouse_item]
    end

    test "get_warehouse_item!/1 returns the warehouse_item with given id" do
      warehouse_item = warehouse_item_fixture()
      assert Warehouse.get_warehouse_item!(warehouse_item.id) == warehouse_item
    end

    test "create_warehouse_item/1 with valid data creates a warehouse_item" do
      assert {:ok, %WarehouseItem{} = warehouse_item} = Warehouse.create_warehouse_item(@valid_attrs)
      assert warehouse_item.price == Decimal.new("120.5")
      assert warehouse_item.sku == "some sku"
      assert warehouse_item.stock_quantity == 42
    end

    test "create_warehouse_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouse_item(@invalid_attrs)
    end

    test "update_warehouse_item/2 with valid data updates the warehouse_item" do
      warehouse_item = warehouse_item_fixture()
      assert {:ok, warehouse_item} = Warehouse.update_warehouse_item(warehouse_item, @update_attrs)
      assert %WarehouseItem{} = warehouse_item
      assert warehouse_item.price == Decimal.new("456.7")
      assert warehouse_item.sku == "some updated sku"
      assert warehouse_item.stock_quantity == 43
    end

    test "update_warehouse_item/2 with invalid data returns error changeset" do
      warehouse_item = warehouse_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouse_item(warehouse_item, @invalid_attrs)
      assert warehouse_item == Warehouse.get_warehouse_item!(warehouse_item.id)
    end

    test "delete_warehouse_item/1 deletes the warehouse_item" do
      warehouse_item = warehouse_item_fixture()
      assert {:ok, %WarehouseItem{}} = Warehouse.delete_warehouse_item(warehouse_item)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouse_item!(warehouse_item.id) end
    end

    test "change_warehouse_item/1 returns a warehouse_item changeset" do
      warehouse_item = warehouse_item_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouse_item(warehouse_item)
    end
  end

  describe "suppliers" do
    alias Mango.Warehouse.Supplier

    @valid_attrs %{contact_person: "some contact_person", email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{contact_person: "some updated contact_person", email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{contact_person: nil, email: nil, name: nil, phone: nil}

    def supplier_fixture(attrs \\ %{}) do
      {:ok, supplier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Warehouse.create_supplier()

      supplier
    end

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Warehouse.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Warehouse.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      assert {:ok, %Supplier{} = supplier} = Warehouse.create_supplier(@valid_attrs)
      assert supplier.contact_person == "some contact_person"
      assert supplier.email == "some email"
      assert supplier.name == "some name"
      assert supplier.phone == "some phone"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      assert {:ok, supplier} = Warehouse.update_supplier(supplier, @update_attrs)
      assert %Supplier{} = supplier
      assert supplier.contact_person == "some updated contact_person"
      assert supplier.email == "some updated email"
      assert supplier.name == "some updated name"
      assert supplier.phone == "some updated phone"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_supplier(supplier, @invalid_attrs)
      assert supplier == Warehouse.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Warehouse.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_supplier(supplier)
    end
  end
end
