defmodule Mango.CRM.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.CRM.{Ticket, Customer} 

  schema "tickets" do
    field :message, :string
    field :status, :string
    field :subject, :string
    belongs_to :customer, Customer

    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:subject, :message, :status])
    |> validate_required([:subject, :message, :status])
  end
end
