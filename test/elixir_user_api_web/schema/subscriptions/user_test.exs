defmodule ElixirUserApiWeb.Schema.Subscription.UserTest do
  use ElixirUserApiWeb.SubscriptionCase

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

  @user_created_subscription_doc """
  subscription userCreated{
    userCreated{
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

  describe "@userCreated" do
    test "send a user when create user mutation is triggered", %{socket: socket} do
      ref = push_doc(socket, @user_created_subscription_doc, variables: %{})

      assert_reply(ref, :ok, %{subscriptionId: subscription_id})

      ref =
        push_doc(socket, @create_user_doc,
          variables: %{
            input: %{
              name: "John",
              email: "test@email.com",
              preferences: %{likesEmails: true, likesPhoneCalls: true, likesFaxes: true}
            }
          }
        )

      assert_reply(ref, :ok, reply)

      assert %{
               data: %{
                 "createUser" => %{
                   "id" => _,
                   "email" => "test@email.com",
                   "name" => "John",
                   "preferences" => %{
                     "likesEmails" => true,
                     "likesFaxes" => true,
                     "likesPhoneCalls" => true
                   }
                 }
               }
             } = reply

      assert_push "subscription:data", data

      assert %{
               subscriptionId: ^subscription_id,
               result: result
             } = data

      assert %{
               data: %{
                 "userCreated" => %{
                   "id" => _,
                   "email" => "test@email.com",
                   "name" => "John",
                   "preferences" => %{
                     "likesEmails" => true,
                     "likesFaxes" => true,
                     "likesPhoneCalls" => true
                   }
                 }
               }
             } = result
    end
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

  @user_preferences_updated_subscription_doc """
  subscription userPreferencesUpdated($userId: ID!){
    userPreferencesUpdated(userId: $userId){
      likesEmails
      likesPhoneCalls
      likesFaxes
    }
  }
  """

  describe "@updatedUserPreferences" do
    test "send a user preference when update user preference mutation is triggered", %{
      socket: socket
    } do
      assert {:ok, user} =
               Accounts.create_user(%{
                 name: "John",
                 email: "test@test.com",
                 preferences: %{
                   likes_emails: true,
                   likes_phone_calls: true,
                   likes_faxes: true
                 }
               })

      ref =
        push_doc(socket, @user_preferences_updated_subscription_doc,
          variables: %{userId: user.id}
        )

      assert_reply(ref, :ok, %{subscriptionId: subscription_id})

      ref =
        push_doc(socket, @update_user_preferences_doc,
          variables: %{
            input: %{
              userId: user.id,
              likesEmails: false,
              likesPhoneCalls: false,
              likesFaxes: false
            }
          }
        )

      assert_reply(ref, :ok, reply)

      assert %{
               data: %{
                 "updateUserPreference" => %{
                   "likesEmails" => false,
                   "likesFaxes" => false,
                   "likesPhoneCalls" => false
                 }
               }
             } = reply

      assert_push "subscription:data", data

      assert %{
               subscriptionId: ^subscription_id,
               result: result
             } = data

      assert %{
               data: %{
                 "userPreferencesUpdated" => %{
                   "likesEmails" => false,
                   "likesFaxes" => false,
                   "likesPhoneCalls" => false
                 }
               }
             } = result
    end
  end
end
