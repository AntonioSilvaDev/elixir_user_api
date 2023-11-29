defmodule ElixirUserApi.Accounts do
  @moduledoc """
  Context for Accounts
  """
  alias EctoShorts.Actions

  alias ElixirUserApi.Accounts.{
    User,
    Preference
  }

  @doc """
  Allows for querying all users.  Can also query for users by preference association.
  ElixirUserApi.Accounts.all_users(%{preferences: %{likes_faxes: true, likes_emails: false}, preload: [:preference]})
  """
  def all_users(params \\ %{})

  def all_users(%{preferences: _} = params) do
    {preference_filters, remaining_params} = Map.pop(params, :preferences)

    User.join_preference()
    |> User.by_preferences(preference_filters)
    |> Actions.all(remaining_params)
  end

  def all_users(params) do
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
