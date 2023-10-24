defmodule ElixirUserApi.Repo do
  use Ecto.Repo,
    otp_app: :elixir_user_api,
    adapter: Ecto.Adapters.Postgres
end
