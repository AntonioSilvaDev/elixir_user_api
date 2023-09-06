defmodule ElixirUserApiWeb.Types.UserPreferences do
  @moduledoc """
  This module will hold the type for User Preferences
  """

  use Absinthe.Schema.Notation

  input_object :create_user_preferences do
    field :likes_emails, non_null(:boolean)
    field :likes_phone_calls, non_null(:boolean)
    field :likes_faxes, non_null(:boolean)
  end

  input_object :update_user_preferences do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end

  object :user_preferences do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end
end