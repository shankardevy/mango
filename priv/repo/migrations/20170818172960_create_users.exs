defmodule Mango.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :citext
      add :phone, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
