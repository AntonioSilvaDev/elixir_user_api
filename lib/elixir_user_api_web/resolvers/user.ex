defmodule ElixirUserApiWeb.Resolvers.User do
  @moduledoc false

  # alias ElixirUserApiWeb.User
  alias ElixirUserApi.Accounts

  def all(%{input: params}, _ctx), do: {:ok, Accounts.all_users(params)}

  def find(%{id: id}, _ctx), do: Accounts.find_user(%{id: id})

  def create(params, _ctx) do
    Accounts.create_user(params)
  end

  def update(%{id: user_id} = params, _ctx) do
    user_id = String.to_integer(user_id)
    params
    |> Map.drop([:id])
    |> then(&Accounts.update_user(user_id, &1))
  end

  def update_preferences(%{user_id: user_id} = params, _ctx) do
    user_id = String.to_integer(user_id)
    params
    |> Map.drop([:user_id])
    |> then(&Accounts.update_user_preferences(user_id, &1))
  end
end