defmodule ElixirUserApiWeb.SubscriptionCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ElixirUserApiWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: ElixirUserApiWeb.Schema

      setup tags do
        ElixirUserApiWeb.DataCase.setup_sandbox(tags)
        {:ok, socket} = Phoenix.ChannelTest.connect(ElixirUserApiWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}
      end
    end
  end
end
