defmodule ElixirUserApiWeb.UserResolver do
  @moduledoc false

  # alias ElixirUserApiWeb.User
  alias ElixirUserApi.Accounts
  alias ElixirUserApiWeb.ResolverHitsCounter

  def all_users(args, _ctx), do: {:ok, Accounts.all_users(args)}

  def find_user(params, _ctx), do: Accounts.find_user(params)

  def create(%{input: input}, _ctx) do
    with {:ok, user} <- Accounts.create_user(input),
         :ok <- ResolverHitsCounter.add_hit("create_user") do
      {:ok, user}
    end
  end

  def update(%{input: input}, _ctx) do
    with {:ok, user} <- Accounts.update_user(input.id, Map.delete(input, :id)),
         :ok <- ResolverHitsCounter.add_hit("update_user") do
      {:ok, user}
    end
  end

  def update_user_preferences(%{input: input}, _ctx) do
    with {:ok, user_preferences} <-
           Accounts.update_user_preferences(input.user_id, Map.delete(input, :user_id)),
         :ok <- ResolverHitsCounter.add_hit("update_user_preferences") do
      {:ok, user_preferences}
    end
  end

  def get_hits(%{mutation_name: mutation_name}, _ctx) do
    with :ok <- ResolverHitsCounter.add_hit("get_hits_count") do
      {:ok, ResolverHitsCounter.get_hits(mutation_name)}
    end
  end
end
