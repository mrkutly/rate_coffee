defmodule RateCoffeeWeb.Schema.UserManagerTypes do
  use Absinthe.Schema.Notation
  alias RateCoffeeWeb.Resolvers

  object :user_manager_mutations do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.UserManager.login/3)
    end
  end

  object :session do
    field :user, :user
    field :token, :string
  end

  object :user do
    field(:email, non_null(:string))
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:thumbnail, non_null(:string))
  end
end
