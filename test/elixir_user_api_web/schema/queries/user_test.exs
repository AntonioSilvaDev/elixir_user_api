defmodule ElixirUserApiWeb.Schema.Queries.UserTest do
  # use ExUnit.Case
  use ElixirUserApiWeb.ConnCase
  alias ElixirUserApi.Accounts

  @find_user_doc """
  query User($id: ID!){
    user(id: $id){
      id
      name
      email
      preferences{
        likesEmails
        likesPhoneCalls
        likesFaxes
      }
    }
  }
  """

  @all_users_doc """
  query Users{
    users{
      id
      name
      email
      preferences{
        likesEmails
        likesPhoneCalls
        likesFaxes
      }
    }
  }
  """
  test "can find a user by id", %{conn: conn} do
    {:ok, user} =
      Accounts.create_user(%{
        "name" => "Bill",
        "email" => "bill@gmail.com",
        "preferences" => %{
          "likes_emails" => false,
          "likes_faxes" => true,
          "likes_phone_calls" => true
        }
      })

    user_id = to_string(user.id)

    conn =
      post(conn, "/api", %{
        "query" => @find_user_doc,
        "variables" => %{id: user.id}
      })

    assert %{
             "data" => %{
               "user" => %{
                 "id" => ^user_id,
                 "email" => "bill@gmail.com",
                 "name" => "Bill",
                 "preferences" => %{
                   "likesEmails" => false,
                   "likesFaxes" => true,
                   "likesPhoneCalls" => true
                 }
               }
             }
           } = json_response(conn, 200)
  end

  test "can get all users", %{conn: conn} do
    {:ok, _user} =
      ElixirUserApi.Accounts.create_user(%{name: "Test User", email: "test@test.com"})

    conn =
      post(conn, "/api", %{
        "query" => @all_users_doc,
        "variables" => %{}
      })

    assert %{
             "data" => %{
               "users" => users
             }
           } = json_response(conn, 200)

    assert length(users) === 1
  end
end
