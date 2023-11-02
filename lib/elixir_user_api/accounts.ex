defmodule ElixirUserApi.Accounts do
  @doc """
  Context for Accounts
  """
  alias EctoShorts.Actions
  alias ElixirUserApi.Accounts.{
    User,
    Preference
  }

  alias ElixirUserApi.Repo

  def all_users(params \\ %{}) do
    params
    |> Enum.reduce(User, &convert_field_to_query/2)
    |> Actions.all()
  end

  def convert_field_to_query({:name, value}, query) do
    User.by_name(query, value)
  end

  def convert_field_to_query({:email, value}, query) do
    User.by_email(query, value)
  end

  def convert_field_to_query({:likes_emails, value}, query) do
    query
    |> User.join_preference()
    |> User.by_likes_emails(value)
  end

  def convert_field_to_query({:likes_faxes, value}, query) do
    query
    |> User.join_preference()
    |> User.by_likes_faxes(value)
  end

  def convert_field_to_query({:likes_phones_calls, value}, query) do
    query
    |> User.join_preference()
    |> User.by_likes_phone_calls(value)
  end

  def convert_field_to_query({:before, value}, query) do
    EctoShorts.CommonFilters.convert_params_to_filter(query, %{before: value})
  end

  def convert_field_to_query({:after, value}, query) do
    EctoShorts.CommonFilters.convert_params_to_filter(query, %{after: value})
  end

  def convert_field_to_query({:first, value}, query) do
    EctoShorts.CommonFilters.convert_params_to_filter(query, %{first: value})
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
