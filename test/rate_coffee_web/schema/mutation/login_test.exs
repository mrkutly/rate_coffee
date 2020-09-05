defmodule RateCoffeeWeb.Schema.Mutation.LoginTest do
  use RateCoffeeWeb.ConnCase, async: true
  alias RateCoffee.UserManager.Auth

  @query """
  mutation Login($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      token
      user {
        email
      }
    }
  }
  """

  test "login returns an auth token when given valid credentials" do
    user = insert(:user)
    conn = build_conn()

    result = conn
      |> post("/api",
        query: @query,
        variables: %{"email" => user.email, "password" => user.password}
      )
      |> json_response(200)

     %{"data" => %{"login" => %{"token" => token, "user" => %{"email" => email}}}} = result
      assert email == user.email

      {:ok, authed, _} = Auth.resource_from_token(token)
      assert authed == clean_password(user)
  end

  test "login returns an error when given invalid credentials" do
    user = insert(:user)
    conn = build_conn()

    result = conn
      |> post("/api",
        query: @query,
        variables: %{"email" => user.email, "password" => user.password <> "JK!"}
      )
      |> json_response(200)

    %{"data" => %{"login" => login}, "errors" => [%{"message" => message}]} = result
    assert is_nil(login)
    assert message == "Incorrect email or password"
  end
end
