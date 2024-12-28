defmodule GateioAuth.Repo.Migrations.AddWalletBalance do
  use Ecto.Migration

  def change do
      create table :gateio_wallet_balance do
        add :spot, :jsonb
        add :delivery, :jsonb
        add :finance, :jsonb
        add :futures, :jsonb
        add :margin, :jsonb
        add :options, :jsonb
        add :payment, :jsonb
        add :pilot, :jsonb
        add :quant, :jsonb

        #tatal fields
        add :total_amount, :decimal
        add :total_borrowed, :decimal
        add :total_currency, :string
        add :total_unrealised_pnl, :decimal
      end
  end
end
