defmodule ElixirUserApiWeb.Types.User do
  @moduledoc """
  This module will hold the context for the User
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preferences, :preference, resolve: dataloader(ElixirUserApi.Accounts, :preference)
  end
end