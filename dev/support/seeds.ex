defmodule RateCoffee.Seeds do
  alias RateCoffee.Bevs
  alias RateCoffee.UserManager

  def run() do
    {:ok, %{id: user_id}} =
      UserManager.create_user(%{
        email: "mark@test.com",
        password: "fake_password1!",
        username: "mrkutly"
      })

    {:ok, %{id: roaster_id}} =
      Bevs.create_roaster(%{city: "anapolis", state: "maryland", country: "US", name: "Ceremony"})

    {:ok, %{id: region_id}} =
      Bevs.create_region(%{name: "Finca Santa Elena", country: "Guatemala"})

    {:ok, %{id: coffee_id}} =
      Bevs.create_coffee(%{
        image: "https://dspncdn.com/a1/media/692x/86/6b/61/866b616f54ac3649e2b46e5cdd0fad9f.jpg",
        name: "Finca Santa Elena",
        roaster_id: roaster_id,
        region_id: region_id
      })

    {:ok, %{id: other_coffee_id}} =
      Bevs.create_coffee(%{
        image: "https://dspncdn.com/a1/media/692x/86/6b/61/866b616f54ac3649e2b46e5cdd0fad9f.jpg",
        name: "House espresso",
        roaster_id: roaster_id,
        region_id: region_id
      })

    {:ok, _review} =
      Bevs.create_review(%{
        user_id: user_id,
        coffee_id: coffee_id,
        content: "This coffee fucking rules",
        rating: 87
      })

    {:ok, _review} =
      Bevs.create_review(%{
        user_id: user_id,
        coffee_id: coffee_id,
        content: "Incredible",
        rating: 92
      })

    {:ok, _review} =
      Bevs.create_review(%{
        user_id: user_id,
        coffee_id: other_coffee_id,
        content: "Wow! Bad!",
        rating: 50
      })

    :ok
  end
end
