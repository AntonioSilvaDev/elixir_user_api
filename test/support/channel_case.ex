defmodule ElixirUserApiWeb.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.
  """

  use ExUnit.CaseTemplate
  require Phoenix.ChannelTest

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import ElixirUserApiWeb.ChannelCase

      # The default endpoint for testing
      @endpoint ElixirUserApiWeb.Endpoint
    end
  end

  setup do
    :ok
  end
end
