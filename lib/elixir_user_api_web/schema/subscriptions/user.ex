defmodule ElixirUserApiWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :user_created, :user do
      trigger(:create_user,
        topic: fn _user ->
          "user_created!"
        end
      )

      config(fn _args, _ ->
        {:ok, topic: "user_created!"}
      end)
    end

    field :user_preferences_updated, :user_preference do
      arg :user_id, non_null(:id)

      trigger(:update_user_preference,
        topic: fn user_preferences ->
          user_preferences.user_id
        end
      )

      config(fn args, _ ->
        {:ok, topic: args.user_id}
      end)
    end
  end
end
