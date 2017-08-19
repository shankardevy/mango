defmodule Mango.Administration.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.Administration.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone])
    |> validate_required([:name, :email, :phone])
    |> unique_constraint(:email)
  end
end
