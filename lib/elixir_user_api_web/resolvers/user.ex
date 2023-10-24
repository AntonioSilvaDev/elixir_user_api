defmodule ElixirUserApiWeb.Resolvers.User do
  @moduledoc false

  # alias ElixirUserApiWeb.User
  alias ElixirUserApi.Accounts

  def all(params, _ctx), do: {:ok, Accounts.all_users(params)}

  def find(%{id: id}, _ctx), do: User.find(%{id: id})

  def create(params, _ctx) do
    Accounts.create_user(params)
  end

  def update(%{id: id} = params, _ctx) do
    params
    |> Map.drop([:id])
    |> then(&User.update(id, &1))
  end

  def update_preferences(%{user_id: user_id} = params, _ctx) do
    params
    |> Map.drop([:user_id])
    |> then(&User.update_user_preferences(user_id, &1))
  end
end