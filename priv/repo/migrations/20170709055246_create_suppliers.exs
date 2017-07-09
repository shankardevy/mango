defmodule Mango.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :contact_person, :string
      add :phone, :string
      add :email, :string

      timestamps()
    end

  end
end
