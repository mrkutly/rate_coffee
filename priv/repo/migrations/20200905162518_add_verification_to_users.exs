defmodule RateCoffee.Repo.Migrations.AddVerificationToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:verified, :boolean, default: false)
      add(:verification_code, :string, null: false)
    end
  end
end
