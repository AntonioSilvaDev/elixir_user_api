defmodule ElixirUserApiWeb.Types.UserPreference do
  @moduledoc """
  This module will hold the type for User Preference
  """

  use Absinthe.Schema.Notation

  input_object :create_user_preference_input do
    field :likes_emails, non_null(:boolean)
    field :likes_phone_calls, non_null(:boolean)
    field :likes_faxes, non_null(:boolean)
  end

  input_object :update_user_preference_input do
    field :user_id, non_null(:id)
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end

  object :user_preference do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end
end
