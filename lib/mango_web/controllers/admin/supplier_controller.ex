defmodule MangoWeb.Admin.SupplierController do
  use MangoWeb, :controller

  alias Mango.Warehouse

  def index(conn, _params) do
    suppliers = Warehouse.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end

  def new(conn, _params) do
    changeset = Warehouse.change_supplier(%Mango.Warehouse.Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    case Warehouse.create_supplier(supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier created successfully.")
        |> redirect(to: admin_supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Warehouse.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def edit(conn, %{"id" => id}) do
    supplier = Warehouse.get_supplier!(id)
    changeset = Warehouse.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Warehouse.get_supplier!(id)

    case Warehouse.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: admin_supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Warehouse.get_supplier!(id)
    {:ok, _supplier} = Warehouse.delete_supplier(supplier)

    conn
    |> put_flash(:info, "Supplier deleted successfully.")
    |> redirect(to: admin_supplier_path(conn, :index))
  end
end
