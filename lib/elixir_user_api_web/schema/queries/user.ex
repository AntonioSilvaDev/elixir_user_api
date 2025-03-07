defmodule ElixirUserApiWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias ElixirUserApiWeb.UserResolver

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)

      resolve &UserResolver.find_user/2
    end

    field :users, list_of(:user) do
      arg :filter, :user_filter_input

      resolve &UserResolver.all_users/2
    end
  end
end
