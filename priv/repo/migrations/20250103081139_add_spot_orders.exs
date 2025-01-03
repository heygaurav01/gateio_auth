defmodule GateioAuth.Repo.Migrations.AddSpotOrders do
  use Ecto.Migration

  def change do
    create table(:spot_orders) do
      add :amend_text, :string
      add :amount, :decimal
      add :create_time, :integer
      add :create_time_ms, :decimal
      add :currency_pair, :string
      add :fee, :decimal
      add :fee_currency, :string
      add :gt_fee, :decimal
      add :trx_id, :string
      add :order_id, :string
      add :point_fee, :decimal
      add :price, :decimal
      add :filled_amount, :decimal
      add :fill_price, :decimal
      add :role, :string
      add :sequence_id, :integer
      add :side, :string
      add :text, :string

      timestamps()
    end

  end
 end
