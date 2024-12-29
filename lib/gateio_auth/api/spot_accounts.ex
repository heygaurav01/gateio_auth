defmodule GateioAuth.GateioSpotAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gateio_spot_accounts" do
    field :currency, :string
    field :available, :decimal
    field :locked, :decimal
    field :update_id, :integer

    timestamps()
  end

  @doc false
  def changeset(gateio_spot_account, attrs) do
    gateio_spot_account
    |> cast(attrs, [:currency, :available, :locked, :update_id])

  end
end
