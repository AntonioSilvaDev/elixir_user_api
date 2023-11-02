defmodule ElixirUserApiWeb.Types.User do
  @moduledoc """
  This module will hold the context for the User
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  input_object :user_query_input do
    field :name, :string
    field :email, :string
    field :likes_emails, :boolean
    field :likes_faxes, :boolean
    field :likes_phone_calls, :boolean

    field :before, :integer
    field :after, :integer
    field :first, :integer
  end

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preferences, :preference, resolve: dataloader(ElixirUserApi.Accounts, :preference)
  end
end