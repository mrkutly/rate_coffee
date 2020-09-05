defmodule RateCoffee.Factory do
  use ExMachina.Ecto, repo: RateCoffee.Repo
  alias RateCoffee.Bevs.{Coffee, Region, Roaster}

  def coffee_factory do
    %{id: roaster_id} = insert(:roaster)
    %{id: region_id} = insert(:region)

    %Coffee{
      image: Faker.Internet.image_url(),
      name: Faker.Beer.name(),
      roaster_id: roaster_id,
      region_id: region_id
    }
  end

  def region_factory do
    %Region{
      country: Faker.Address.country(),
      name: Faker.Address.state()
    }
  end

  def roaster_factory do
    %Roaster{
      country: Faker.Address.country(),
      city: Faker.Address.city(),
      image: Faker.Internet.image_url(),
      name: Faker.Company.name(),
      state: Faker.Address.state()
    }
  end

  def input_from(%Coffee{} = coffee) do
    %{
      "image" => coffee.image,
      "name" => coffee.name,
      "region_id" => coffee.region_id,
      "roaster_id" => coffee.roaster_id
    }
  end
end
