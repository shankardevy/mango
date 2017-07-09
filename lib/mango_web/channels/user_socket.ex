defmodule MangoWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
<<<<<<< HEAD:lib/mango_web/channels/user_socket.ex
  # channel "room:*", MangoWeb.RoomChannel
=======
  channel "pos", Mango.Web.BotChannel
>>>>>>> e687d85... Setup chat interface and channel:lib/mango/web/channels/user_socket.ex

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

<<<<<<< HEAD:lib/mango_web/channels/user_socket.ex
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     MangoWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
=======
>>>>>>> e687d85... Setup chat interface and channel:lib/mango/web/channels/user_socket.ex
  def id(_socket), do: nil
end
