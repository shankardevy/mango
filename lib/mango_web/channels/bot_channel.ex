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

  def handle_in(_, payload, socket) do
    reply = %{ message: "I don't understand your question." }
    {:reply, {:error, reply}, socket}
  end

end
