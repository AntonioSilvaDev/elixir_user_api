defmodule ElixirUserApi.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:user_id]
  @allowed_fields [:likes_emails, :likes_faxes, :likes_phone_calls | @required_fields]

  schema "user_preferences" do
    belongs_to :user, ElixirUserApi.Accounts.User

    field :likes_emails, :boolean
    field :likes_faxes, :boolean
    field :likes_phone_calls, :boolean
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
  end

  def create_changeset(params) do
    changeset(%ElixirUserApi.Accounts.Preference{}, params)
  end
end
