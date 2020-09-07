defmodule RateCoffeeWeb.Schema.UserManagerTypes do
  use Absinthe.Schema.Notation
  alias RateCoffeeWeb.Resolvers
  alias RateCoffee.Bevs.Review
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :user_manager_mutations do
    field :login, :session do
      arg(:email, non_null(:email))
      arg(:password, non_null(:string))
      resolve(&Resolvers.UserManager.login/3)
    end
  end

  object :session do
    field :user, :user
    field :token, :string
  end

  object :user do
    field(:email, non_null(:email))
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:thumbnail, non_null(:string))
    field :reviews, list_of(:review), resolve: dataloader(Review)
  end
end
