defmodule RateCoffee.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Argon2

  schema "users" do
    field :email, :string
    field :password, :string
    field :thumbnail, :string
    field :username, :string

    has_many(:reviews, RateCoffee.Bevs.Review)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :thumbnail])
    |> validate_required([:username, :email, :password])
    |> unique_constraint([:email, :username])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
