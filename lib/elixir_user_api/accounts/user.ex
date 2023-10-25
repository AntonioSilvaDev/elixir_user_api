defmodule ElixirUserApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

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
end
