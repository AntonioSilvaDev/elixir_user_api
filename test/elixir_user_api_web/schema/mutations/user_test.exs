defmodule ElixirUserApiWeb.Schema.Mutations.UserTest do
  # use ExUnit.Case
  use ElixirUserApiWeb.ConnCase

  alias ElixirUserApi.Accounts

  @create_user_doc """
  mutation CreateUser($input: CreateUserInput!){
    createUser(input: $input){
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

  test "can create a user", %{conn: conn} do
    conn =
      post(conn, "/api", %{
        "query" => @create_user_doc,
        "variables" => %{
          "input" => %{
            "name" => "Bob",
            "email" => "test@test.com",
            "preferences" => %{
              "likesEmails" => true,
              "likesPhoneCalls" => false,
              "likesFaxes" => true
            }
          }
        }
      })

    assert %{
             "data" => %{
               "createUser" => %{
                 "email" => "test@test.com",
                 "name" => "Bob",
                 "preferences" => %{
                   "likesEmails" => true,
                   "likesFaxes" => true,
                   "likesPhoneCalls" => false
                 }
               }
             }
           } = json_response(conn, 200)
  end

  @update_user_doc """
  mutation UpdateUser($input: UpdateUserInput!){
    updateUser(input: $input){
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

  test "can update a user", %{conn: conn} do
    {:ok, user} =
      Accounts.create_user(%{
        name: "Test User",
        email: "test@test.com"
      })

    conn =
      post(conn, "/api", %{
        "query" => @update_user_doc,
        "variables" => %{
          "input" => %{
            "id" => user.id,
            "name" => "New Updated Name",
            "email" => "updatedemailtest@test.com"
          }
        }
      })

    assert %{
             "data" => %{
               "updateUser" => %{
                 "id" => user_id,
                 "name" => "New Updated Name",
                 "email" => "updatedemailtest@test.com"
               }
             }
           } = json_response(conn, 200)

    assert String.to_integer(user_id) === user.id
  end

  @update_user_preferences_doc """
  mutation UpdateUserPreference($input: UpdateUserPreferenceInput!){
    updateUserPreference(input: $input){
      likesEmails
      likesPhoneCalls
      likesFaxes
    }
  }
  """

  test "can update a users preferences", %{conn: conn} do
    {:ok, %{preferences: preferences} = user} =
      Accounts.create_user(%{
        name: "Test User",
        email: "test@test.com",
        preferences: %{
          likes_emails: false,
          likes_phone_calls: false,
          likes_faxes: false
        }
      })

    assert %{
             likes_emails: false,
             likes_phone_calls: false,
             likes_faxes: false
           } = preferences

    conn =
      post(conn, "/api", %{
        "query" => @update_user_preferences_doc,
        "variables" => %{
          "input" => %{
            "user_id" => user.id,
            "likes_emails" => true,
            "likes_phone_calls" => true,
            "likes_faxes" => true
          }
        }
      })

    assert %{
             "data" => %{
               "updateUserPreference" => %{
                 "likesEmails" => true,
                 "likesPhoneCalls" => true,
                 "likesFaxes" => true
               }
             }
           } = json_response(conn, 200)
  end
end
