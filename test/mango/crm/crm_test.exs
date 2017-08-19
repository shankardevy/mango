defmodule Mango.CRMTest do
  use Mango.DataCase
  alias Mango.CRM
  alias Mango.CRM.Customer

  test "build_customer/0 returns a customer changeset" do
    assert %Ecto.Changeset{data: %Customer{}} = CRM.build_customer
  end

  test "build_customer/1 returns a customer changeset with values applied" do
    attrs = %{"name" => "John"}
    changeset = CRM.build_customer(attrs)
    assert changeset.params == attrs
  end

  test "create_customer/1 returns a customer for valid data" do
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    assert {:ok, customer} = CRM.create_customer(valid_attrs)
    assert Comeonin.Bcrypt.checkpw(valid_attrs["password"], customer.password_hash)
  end

  test "create_customer/1 returns a changeset for invalid data" do
    invalid_attrs = %{}
    assert {:error, %Ecto.Changeset{}} = CRM.create_customer(invalid_attrs)
  end

  test "get_customer_by_email" do
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    {:ok, customer1} = CRM.create_customer(valid_attrs)
    customer2 = CRM.get_customer_by_email("john@example.com")
    assert customer1.id == customer2.id
  end

  test "get_customer_by_credentials" do
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    {:ok, customer1} = CRM.create_customer(valid_attrs)
    customer2 = CRM.get_customer_by_credentials(valid_attrs)
    assert customer1.id == customer2.id
  end

  describe "tickets" do
    alias Mango.CRM.Ticket

    @valid_attrs %{message: "some message", status: "some status", subject: "some subject"}
    @update_attrs %{message: "some updated message", status: "some updated status", subject: "some updated subject"}
    @invalid_attrs %{message: nil, status: nil, subject: nil}

    def ticket_fixture(attrs \\ %{}) do
      {:ok, ticket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CRM.create_ticket()

      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert CRM.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert CRM.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = CRM.create_ticket(@valid_attrs)
      assert ticket.message == "some message"
      assert ticket.status == "some status"
      assert ticket.subject == "some subject"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CRM.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      assert {:ok, ticket} = CRM.update_ticket(ticket, @update_attrs)
      assert %Ticket{} = ticket
      assert ticket.message == "some updated message"
      assert ticket.status == "some updated status"
      assert ticket.subject == "some updated subject"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = CRM.update_ticket(ticket, @invalid_attrs)
      assert ticket == CRM.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = CRM.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> CRM.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = CRM.change_ticket(ticket)
    end
  end
end
