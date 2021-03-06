defmodule RateCoffee.UserManager.User do
  use Ecto.Schema
  use RateCoffee.Dataloader
  import Ecto.Changeset
  alias Argon2

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :thumbnail, :string
    field :username, :string
    field :verification_code, :string

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
    |> put_verification_code()
  end

  def put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  def put_password_hash(changeset), do: changeset

  defp put_verification_code(%Ecto.Changeset{valid?: true} = changeset) do
    verification_code = RateCoffee.Helpers.random_byte_string(24)
    change(changeset, verification_code: verification_code)
  end

  defp put_verification_code(changeset), do: changeset
end
