defmodule GateioAuth.SpotOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "spot_orders" do
    field :amend_text, :string
    field :amount, :decimal
    field :create_time, :integer
    field :create_time_ms, :decimal
    field :currency_pair, :string
    field :fee, :decimal
    field :fee_currency, :string
    field :gt_fee, :decimal
    field :trx_id, :string
    field :order_id, :string
    field :point_fee, :decimal
    field :price, :decimal
    field :filled_amount, :decimal
    field :fill_price, :decimal
    field :role, :string
    field :sequence_id, :integer
    field :side, :string
    field :text, :string


    timestamps()
  end

  @doc false
  def changeset(spot_order, attrs) do
    spot_order
    |> cast(attrs, [:amend_text, :amount, :create_time, :create_time_ms, :currency_pair, :fee, :fee_currency,
    :gt_fee, :trx_id, :order_id, :point_fee, :price, :filled_amount, :fill_price,
    :role, :sequence_id, :side, :text ])
    |> unique_constraint(:order_id, name: :spot_orders_order_id_index)
  end
end
