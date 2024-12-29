defmodule GateioAuth.Repo.Migrations.AddSpotAccounts do
  use Ecto.Migration

  def change do
    create table(:gateio_spot_accounts) do
      add :currency, :string
      add :available, :decimal
      add :locked, :decimal
      add :update_id, :integer
      timestamps()
    end
  end
end
