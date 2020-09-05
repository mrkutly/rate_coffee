defmodule RateCoffee.UserManagerTest do
  use RateCoffee.DataCase

  alias RateCoffee.UserManager

  describe "users" do
    alias RateCoffee.UserManager.User

    @valid_attrs %{
      email: "some email",
      password: "some password",
      thumbnail: "some thumbnail",
      username: "some username"
    }
    @update_attrs %{
      email: "some updated email",
      password: "some updated password",
      thumbnail: "some updated thumbnail",
      username: "some updated username"
    }
    @invalid_attrs %{email: nil, password: nil, thumbnail: nil, username: nil}

    test "list_users/0 returns all users" do
      user =
        insert(:user)
        |> clean_password()

      assert UserManager.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user) |> clean_password
      assert UserManager.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = UserManager.create_user(@valid_attrs)
      assert {:ok, user} == Argon2.check_pass(user, "some password", hash_key: :password_hash)
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserManager.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      assert {:ok, %User{} = user} = UserManager.update_user(user, @update_attrs)

      assert {:ok, user} ==
               Argon2.check_pass(user, "some updated password", hash_key: :password_hash)

      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user =
        insert(:user)
        |> clean_password

      assert {:error, %Ecto.Changeset{}} = UserManager.update_user(user, @invalid_attrs)
      assert user == UserManager.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = UserManager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserManager.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = UserManager.change_user(user)
    end
  end
end
