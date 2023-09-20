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

  subscription do
    field :user_created, :user do
      trigger :create_user, topic: fn user ->
        "user_created"
      end

      config fn _, _ ->
        {:ok, topic: "user_created"}
      end
    end

    field :updated_user_preferences, :user_preferences do
      arg :user_id, non_null(:id)

      trigger :update_user_preferences, topic: fn user_preferences ->
        user_preferences.user_id
      end

      config fn args, _ ->
        {:ok, topic: args.user_id}
      end
    end
  end

end