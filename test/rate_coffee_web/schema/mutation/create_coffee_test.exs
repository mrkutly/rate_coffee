defmodule RateCoffeeWeb.Schema.Mutation.CreateCoffeeTest do
  use RateCoffeeWeb.ConnCase, async: true

  @query """
  mutation CreateCoffee($input: CoffeeInput) {
    createCoffee(input: $input) {
      coffee {
        name
      }
      errors {
        key
        message
      }
    }
  }
  """
  test "creates and returns a coffee when given valid inputs" do
    coffee = build(:coffee)

    variables = %{
      "input" => input_from(coffee)
    }

    conn = build_conn()

    conn =
      post(conn, "/api",
        query: @query,
        variables: variables
      )

    assert json_response(conn, 200) == %{
             "data" => %{
               "createCoffee" => %{"coffee" => %{"name" => coffee.name}, "errors" => nil}
             }
           }
  end

  test "returns errors when given invalid inputs" do
    conn = build_conn()

    conn =
      post(conn, "/api",
        query: @query,
        variables: %{"input" => %{}}
      )

    assert json_response(conn, 200) == %{
             "errors" => [
               %{
                 "locations" => [%{"column" => 16, "line" => 2}],
                 "message" =>
                   String.trim("""
                   Argument "input" has invalid value $input.
                   In field "roasterId": Expected type "ID!", found null.
                   In field "regionId": Expected type "ID!", found null.
                   In field "name": Expected type "String!", found null.
                   """)
               }
             ]
           }
  end
end
