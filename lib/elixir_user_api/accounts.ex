defmodule ElixirUserApi.Accounts do
  @doc """
  Context for Accounts
  """
  alias EctoShorts.Actions
  alias ElixirUserApi.Accounts.{
    User,
    Preference
  }

  def all_users(params \\ %{}) do
    Actions.all(User, params)
  end

  def find_user(params \\ %{}) do
    Actions.find(User, params)
  end

  def create_user(params \\ %{}) do
    Actions.create(User, params)
  end

  def update_user(id, params \\ %{}) do
    Actions.update(User, id, params)
  end

  def update_user_preferences(user_id, params \\ %{}) do
    Actions.find_and_upsert(Preference, %{user_id: user_id}, params)
  end
end
