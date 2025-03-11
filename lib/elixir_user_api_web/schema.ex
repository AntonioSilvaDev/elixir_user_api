defmodule ElixirUserApiWeb.Schema do
  @moduledoc """
  This module defines the schema for the GraphQL API.
  """
  use Absinthe.Schema

  import_types ElixirUserApiWeb.Types.{
    User,
    UserPreference
  }

  import_types ElixirUserApiWeb.Schema.Queries.User
  import_types ElixirUserApiWeb.Schema.Mutations.User
  import_types ElixirUserApiWeb.Schema.Subscriptions.User

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end

  subscription do
    import_fields :user_subscriptions
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(ElixirUserApi.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), ElixirUserApi.Accounts, source)

    Map.put(ctx, :loader, dataloader)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
