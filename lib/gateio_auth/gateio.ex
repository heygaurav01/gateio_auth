defmodule GateioAuth.Gateio do
  def insert_wallet_balance(data) do
    changeset = GateioAuth.WalletMigration.changeset(%GateioAuth.WalletMigration{}, data)
    GateioAuth.Repo.insert(changeset, [])
  end
end
