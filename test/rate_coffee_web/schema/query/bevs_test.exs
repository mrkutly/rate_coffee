defmodule RateCoffeeWeb.Schema.Query.BevsTest do
  use RateCoffeeWeb.ConnCase, async: true

  @query """
  {
    coffees {
      name
    }
  }
  """
  test "coffees returns list of coffees" do
    coffee = insert(:coffee)
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{"coffees" => [%{"name" => coffee.name}]}
           }
  end

  @query """
  query Coffee($id: ID!) {
    coffee(id: $id) {
      name
    }
  }
  """
  test "coffee returns a single coffee" do
    coffee = insert(:coffee)
    conn = build_conn()
    conn = get(conn, "/api", query: @query, variables: %{"id" => coffee.id})

    assert json_response(conn, 200) == %{
             "data" => %{"coffee" => %{"name" => coffee.name}}
           }
  end

  test "coffee returns an error when the coffee is not found" do
    coffee = insert(:coffee)
    bad_id = coffee.id + 1
    conn = build_conn()
    conn = get(conn, "/api", query: @query, variables: %{"id" => bad_id})

    assert json_response(conn, 200) == %{
             "data" => %{"coffee" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "No coffee found with id #{bad_id}.",
                 "path" => ["coffee"]
               }
             ]
           }
  end
end
