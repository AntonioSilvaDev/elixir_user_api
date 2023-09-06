defmodule ElixirUserApiWeb.Types.User do
  @moduledoc """
  This module will hold the context for the User
  """

  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preferences, :user_preferences
  end
end