defmodule Mango.Warehouse do
  @moduledoc """
  The boundary for the Warehouse system.
  """

  import Ecto.Query, warn: false
  alias Mango.Repo

  alias Mango.Warehouse.WarehouseItem

  @doc """
  Returns the list of warehouse_items.

  ## Examples

      iex> list_warehouse_items()
      [%WarehouseItem{}, ...]

  """
  def list_warehouse_items do
    Repo.all(WarehouseItem)
  end

  @doc """
  Gets a single warehouse_item.

  Raises `Ecto.NoResultsError` if the Ware house item does not exist.

  ## Examples

      iex> get_warehouse_item!(123)
      %WarehouseItem{}

      iex> get_warehouse_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warehouse_item!(id), do: Repo.get!(WarehouseItem, id)

  @doc """
  Creates a warehouse_item.

  ## Examples

      iex> create_warehouse_item(%{field: value})
      {:ok, %WarehouseItem{}}

      iex> create_warehouse_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warehouse_item(attrs \\ %{}) do
    %WarehouseItem{}
    |> WarehouseItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warehouse_item.

  ## Examples

      iex> update_warehouse_item(warehouse_item, %{field: new_value})
      {:ok, %WarehouseItem{}}

      iex> update_warehouse_item(warehouse_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warehouse_item(%WarehouseItem{} = warehouse_item, attrs) do
    warehouse_item
    |> WarehouseItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a WarehouseItem.

  ## Examples

      iex> delete_warehouse_item(warehouse_item)
      {:ok, %WarehouseItem{}}

      iex> delete_warehouse_item(warehouse_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warehouse_item(%WarehouseItem{} = warehouse_item) do
    Repo.delete(warehouse_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warehouse_item changes.

  ## Examples

      iex> change_warehouse_item(warehouse_item)
      %Ecto.Changeset{source: %WarehouseItem{}}

  """
  def change_warehouse_item(%WarehouseItem{} = warehouse_item) do
    WarehouseItem.changeset(warehouse_item, %{})
  end

  alias Mango.Warehouse.Supplier

  @doc """
  Returns the list of suppliers.

  ## Examples

      iex> list_suppliers()
      [%Supplier{}, ...]

  """
  def list_suppliers do
    Repo.all(Supplier)
  end

  @doc """
  Gets a single supplier.

  Raises `Ecto.NoResultsError` if the Supplier does not exist.

  ## Examples

      iex> get_supplier!(123)
      %Supplier{}

      iex> get_supplier!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supplier!(id), do: Repo.get!(Supplier, id)

  @doc """
  Creates a supplier.

  ## Examples

      iex> create_supplier(%{field: value})
      {:ok, %Supplier{}}

      iex> create_supplier(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supplier(attrs \\ %{}) do
    %Supplier{}
    |> Supplier.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supplier.

  ## Examples

      iex> update_supplier(supplier, %{field: new_value})
      {:ok, %Supplier{}}

      iex> update_supplier(supplier, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supplier(%Supplier{} = supplier, attrs) do
    supplier
    |> Supplier.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Supplier.

  ## Examples

      iex> delete_supplier(supplier)
      {:ok, %Supplier{}}

      iex> delete_supplier(supplier)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supplier(%Supplier{} = supplier) do
    Repo.delete(supplier)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supplier changes.

  ## Examples

      iex> change_supplier(supplier)
      %Ecto.Changeset{source: %Supplier{}}

  """
  def change_supplier(%Supplier{} = supplier) do
    Supplier.changeset(supplier, %{})
  end
end
