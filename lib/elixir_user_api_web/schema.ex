defmodule ElixirUserApiWeb.Schema do
  @moduledoc """
  This module defines the schema for the GraphQL API.
  """
  use Absinthe.Schema

  import_types ElixirUserApiWeb.Types.User
  import_types ElixirUserApiWeb.Types.UserPreferences

  import_types ElixirUserApiWeb.Schema.Queries.User
  import_types ElixirUserApiWeb.Schema.Mutations.User

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end

  def subscription do
    # create user subscription
    # update user preferences subscription
  end

end