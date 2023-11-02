defmodule ElixirUserApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @allowed_fields [:name, :email]

  schema "users" do
    has_one :preference, ElixirUserApi.Accounts.Preference

    field :name, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> EctoShorts.CommonChanges.preload_change_assoc(:preference)
  end

  def create_changeset(params) do
    changeset(%ElixirUserApi.Accounts.User{}, params)
  end

  def by_name(query \\ ElixirUserApi.Accounts.User, name) do
    searched_name = "%#{name}%"
    where(query, [u], ilike(u.name, ^searched_name))
  end

  def by_email(query \\ ElixirUserApi.Accounts.User, email) do
    searched_email = "%#{email}%"
    where(query, [u], ilike(u.email, ^searched_email))
  end

  def join_preference(query \\ ElixirUserApi.Accounts.User) do
    if has_named_binding?(query, :preference) do
      query
    else
      join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
    end
  end

  def by_likes_emails(query \\ join_preference(), preference)do
    where(query, [preference: p], p.likes_emails == ^preference)
  end

  def by_likes_faxes(query \\ join_preference(), preference) do
    where(query, [preference: p], p.likes_faxes == ^preference)
  end

  def by_likes_phone_calls(query \\ join_preference(), preference) do
    where(query, [preference: p], p.likes_phone_calls == ^preference)
  end
end
