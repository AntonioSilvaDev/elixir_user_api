defmodule ElixirUserApiWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  alias ElixirUserApiWeb.UserResolver

  object :user_mutations do
    field :create_user, :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
    end

    field :update_user, :user do
      arg :input, non_null(:update_user_input)

      resolve &UserResolver.update/2
    end

    field :update_user_preference, :user_preference do
      arg :input, non_null(:update_user_preference_input)

      resolve &UserResolver.update_user_preferences/2
    end
  end
end
