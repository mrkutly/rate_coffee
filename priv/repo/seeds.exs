alias RateCoffee.Bevs
alias RateCoffee.UserManager

UserManager.create_user(%{
  email: "mark@test.com",
  password: "fake_password1!",
  username: "mrkutly"
})

{:ok, %{id: roaster_id}} =
  Bevs.create_roaster(%{city: "anapolis", state: "maryland", country: "US", name: "Ceremony"})

{:ok, %{id: region_id}} = Bevs.create_region(%{name: "Finca Santa Elena", country: "Guatemala"})

{:ok, _coffee} =
  Bevs.create_coffee(%{name: "Finca Santa Elena", roaster_id: roaster_id, region_id: region_id})

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RateCoffee.Repo.insert!(%RateCoffee.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
