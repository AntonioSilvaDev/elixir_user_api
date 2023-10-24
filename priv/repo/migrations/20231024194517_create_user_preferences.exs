defmodule ElixirUserApi.Repo.Migrations.CreateUserPreferences do
  use Ecto.Migration

  def change do
    create table(:user_preferences) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :likes_emails, :boolean, default: true, null: false
      add :likes_phone_calls, :boolean, default: true, null: false
      add :likes_faxes, :boolean, default: true, null: false
    end
  end
end
