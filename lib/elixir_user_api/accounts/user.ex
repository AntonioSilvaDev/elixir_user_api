defmodule ElixirUserApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :email]
  @allowed_fields [:preferences | @required_fields]

  schema "users" do
    field :name, :string
    field :email, :string
    has_one :preferences, ElixirUserApi.Accounts.Preference

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
    |> EctoShorts.CommonChanges.preload_change_assoc(:preferences)
  end

  def create_changeset(params) do
    changeset(%ElixirUserApi.Accounts.User{}, params)
  end
end
