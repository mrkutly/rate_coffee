alias RateCoffee.Bevs
alias RateCoffee.UserManager

{:ok, %{id: user_id}} =
  UserManager.create_user(%{
    email: "mark@test.com",
    password: "fake_password1!",
    username: "mrkutly"
  })

{:ok, %{id: roaster_id}} =
  Bevs.create_roaster(%{city: "anapolis", state: "maryland", country: "US", name: "Ceremony"})

{:ok, %{id: region_id}} = Bevs.create_region(%{name: "Finca Santa Elena", country: "Guatemala"})

{:ok, %{id: coffee_id}} =
  Bevs.create_coffee(%{name: "Finca Santa Elena", roaster_id: roaster_id, region_id: region_id})

{:ok, _review} =
  Bevs.create_review(%{
    user_id: user_id,
    coffee_id: coffee_id,
    content: "This coffee fucking rules",
    rating: 87
  })
