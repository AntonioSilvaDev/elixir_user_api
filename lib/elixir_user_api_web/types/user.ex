defmodule ElixirUserApiWeb.Types.User do
  @moduledoc """
  This module will hold the context for the User
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  input_object :user_filter_input do
    field :name, :string
    field :email, :string
    field :likes_emails, :boolean
    field :likes_faxes, :boolean
    field :likes_phone_calls, :boolean

    field :before, :integer
    field :after, :integer
    field :first, :integer
  end

  input_object :create_user_input do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :preferences, non_null(:create_user_preference_input)
  end

  input_object :update_user_input do
    field :id, non_null(:id)
    field :name, :string
    field :email, :string
  end

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :preferences, resolve: dataloader(ElixirUserApi.Accounts, :preferences)
  end
end
