defmodule RateCoffeeWeb.Schema.Query.BevsTest do
  use RateCoffeeWeb.ConnCase, async: true

  setup do
    RateCoffee.Seeds.run()
  end

  @query """
  {
    coffees {
      name
    }
  }
  """
  test "coffees returns list of coffees" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{"coffees" => [%{"name" => "Finca Santa Elena"}]}
           }
  end
end
