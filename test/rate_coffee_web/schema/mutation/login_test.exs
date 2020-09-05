defmodule RateCoffeeWeb.Schema.Mutation.LoginTest do
  use RateCoffeeWeb.ConnCase, async: true

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
    # conn = build_conn()
    IO.inspect(user)
    # conn =
    #   post(conn, "/api",
    #     query: @query,
    #     variables: %{"email" => user.email, "password" => user.password}
    #   )

    # assert json_response(conn, 200) == %{}
  end
end
