defmodule RateCoffee.Factory do
  use ExMachina.Ecto, repo: RateCoffee.Repo
  alias RateCoffee.Bevs.{Coffee, Region, Roaster}
  import RateCoffee.Helpers, only: [slugify: 1]
  alias RateCoffee.UserManager.User

  def coffee_factory do
    %{id: roaster_id} = insert(:roaster)
    %{id: region_id} = insert(:region)
    name = Faker.Beer.name()
    slug = slugify(name)

    %Coffee{
      image: Faker.Internet.image_url(),
      name: name,
      roaster_id: roaster_id,
      region_id: region_id,
      slug: slug
    }
  end

  def region_factory do
    %Region{
      country: Faker.Address.country(),
      name: Faker.Address.state()
    }
  end

  def roaster_factory do
    name = Faker.Company.name()
    slug = slugify(name)

    %Roaster{
      country: Faker.Address.country(),
      city: Faker.Address.city(),
      image: Faker.Internet.image_url(),
      name: name,
      slug: slug,
      state: Faker.Address.state()
    }
  end

  def user_factory do
    password = Faker.Superhero.name()

    %User{
      username: Faker.Internet.user_name(),
      email: Faker.Internet.email(),
      thumbnail: Faker.Internet.image_url(),
      password: password,
      password_hash: Argon2.hash_pwd_salt(password),
      verification_code: Faker.String.base64(24)
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

  def clean_password(%User{} = user) do
    %User{user | password: nil}
  end
end
