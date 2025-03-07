defmodule ElixirUserApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @required_fields [:name, :email]
  @allowed_fields [] ++ @required_fields
  @allowed_preference_query_fields [:likes_emails, :likes_faxes, :likes_phone_calls]

  schema "users" do
    has_one :preferences, ElixirUserApi.Accounts.UserPreference

    field :name, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> EctoShorts.CommonChanges.preload_change_assoc(:preferences)
  end

  def create_changeset(params) do
    changeset(%ElixirUserApi.Accounts.User{}, params)
  end

  def join_preference(query \\ ElixirUserApi.Accounts.User) do
    if has_named_binding?(query, :preference) do
      query
    else
      join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
    end
  end

  def by_preferences(query, params) do
    Enum.reduce(
      params,
      query,
      fn
        {k, v}, q when k in @allowed_preference_query_fields and is_boolean(v) ->
          where(q, [u, preference], field(preference, ^k) == ^v)

        _, q ->
          q
      end
    )
  end
end
