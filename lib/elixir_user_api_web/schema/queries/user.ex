defmodule ElixirUserApiWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias ElixirUserApiWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)

      resolve &Resolvers.User.find/2
    end

    field :users, list_of(:user) do
      arg :input, :user_query_input

      resolve &Resolvers.User.all/2
    end
  end
end