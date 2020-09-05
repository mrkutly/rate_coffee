defmodule RateCoffeeWeb.Resolvers.UserManager do
  alias RateCoffee.UserManager
  alias RateCoffee.UserManager.Auth

  def login(_, %{email: email, password: password}, _) do
    case UserManager.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Auth.encode_and_sign(user)
        {:ok, %{token: token, user: user}}

      {:error, _} ->
        {:error, "Incorrect email or password"}
    end
  end
end
