defmodule ElixirUserApiWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: ElixirUserApiWeb.Schema

  ## Channels
  channel "users", ElixirUserApiWeb.UserChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
