defmodule ElixirUserApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :email]
  @allowed_fields [:preferences | @required_fields]

  schema "users" do
    field :name, :string
    field :email, :string
    has_one :preferences, ElixirUserApi.Accounts.UserPreferences

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> EctoShorts.CommonChanges.preload_change_assoc(:preferences)
    |> IO.inspect(label: "user changeset")
  end

  def create_changeset(params) do
    changeset(%ElixirUserApi.Accounts.User{}, params)
  end
end
