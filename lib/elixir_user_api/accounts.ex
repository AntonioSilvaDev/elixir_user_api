defmodule ElixirUserApi.Accounts do
  @doc """
  Context for Accounts
  """
  alias EctoShorts.Actions
  alias ElixirUserApi.Accounts.User

  def all_users(params \\ %{}) do
    Actions.all(User, params)
  end

  def create_user(params \\ %{}) do
    Actions.create(User, params)
  end
end
