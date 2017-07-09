defmodule Mango.Warehouse.Supplier do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.Warehouse.Supplier


  schema "suppliers" do
    field :contact_person, :string
    field :email, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%Supplier{} = supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :contact_person, :phone, :email])
    |> validate_required([:name, :contact_person, :phone, :email])
  end
end
