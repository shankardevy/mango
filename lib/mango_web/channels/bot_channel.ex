defmodule MangoWeb.BotChannel do
  use MangoWeb, :channel
  alias Mango.Sales

  def join("pos", payload, socket) do
    welcome_text = "Hello! Welcome to Mango Point of Sale"
    {:ok, %{message: welcome_text}, socket}
  end

  def handle_in("status", payload, socket) do
    reply = case Sales.get_order(payload["message"]) do
      nil -> %{ message: "Order not found." }
      order -> %{ message: "Status: #{order.status}"}
    end
    {:reply, {:ok, reply}, socket}
  end

  def handle_in("new", _, socket) do
    order = Sales.create_cart()
    new_socket = socket |> assign(:order, order)
    reply = %{ message: "New Order in Progress: ##{order.id}" }
    {:reply, {:ok, reply}, new_socket}
  end

  def handle_in("add", payload, socket) do
    item = String.split(payload["message"], " ")
    reply = case [socket.assigns[:order], item] do
      [nil, _] ->
        %{ message: "Please create a new order before proceeding." }
      [order, [product_id, quantity]] ->
        {:ok, order} = Sales.add_to_cart(order, %{"product_id" => product_id, "quantity" => quantity})
        socket = socket |> assign(:order, order)
        %{ message: "Product added to order." }
      _ ->
        %{ message: "Error" }
    end

    {:reply, {:ok, reply}, socket}
  end

  def handle_in("complete", _, socket) do
    reply = case socket.assigns[:order] do
      nil ->
        %{ message: "Please create a new order before proceeding." }
      order ->
        Sales.pos_sale_complete(order)
        socket = socket |> assign(:order, nil)
        %{ message: "Sale complete. Order total is INR #{order.total}" }
    end

    {:reply, {:ok, reply}, socket}
  end

  def handle_in(_, payload, socket) do
    reply = %{ message: "I don't understand your question." }
    {:reply, {:error, reply}, socket}
  end

end
