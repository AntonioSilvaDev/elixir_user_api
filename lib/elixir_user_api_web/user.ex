defmodule ElixirUserApiWeb.User do
  @moduledoc """
  This module will hold the context for the User
  """

  @users [%{
    id: 1,
    name: "Bill",
    email: "bill@gmail.com",
    preferences: %{
      likes_emails: false,
      likes_phone_calls: true,
      likes_faxes: true
    }
  }, %{
    id: 2,
    name: "Alice",
    email: "alice@gmail.com",
    preferences: %{
      likes_emails: true,
      likes_phone_calls: false,
      likes_faxes: true
    }
  }, %{
    id: 3,
    name: "Jill",
    email: "jill@hotmail.com",
    preferences: %{
      likes_emails: true,
      likes_phone_calls: true,
      likes_faxes: false
    }
  }, %{
    id: 4,
    name: "Tim",
    email: "tim@gmail.com",
    preferences: %{
      likes_emails: false,
      likes_phone_calls: false,
      likes_faxes: false
    }
  }]

  def all(params) do
    @users
    |> Enum.filter(fn user ->
      params
      |> Map.to_list()
      |> Enum.all?(fn {key, value} ->
        Map.get(user.preferences, key) === value
      end)
    end)
    |> then(&{:ok, &1})
  end

  def find(%{id: id}) do
    {:ok, Enum.find(@users, & &1.id === id)}
  end

  def create(params) do
    {:ok, params}
  end

  def update(id, params) do
    id = String.to_integer(id)
    user_to_update = Enum.find(@users, & &1.id === id)

    if user_to_update === nil do
      {:error, "User not found"}
    else
      updated_user = Map.merge(user_to_update, params)
      {:ok, updated_user}
    end
  end

  def update_user_preferences(user_id, params) do
    user_id = String.to_integer(user_id)
    user_to_update = Enum.find(@users, & &1.id === user_id)

    if user_to_update === nil do
      {:error, "User not found"}
    else
      user_to_update
      |> update_in([:preferences], &Map.merge(&1, params))
      |> then(&(&1.preferences))
      |> Map.put(:user_id, user_id)
      |> then(&{:ok, &1})
    end
  end
end