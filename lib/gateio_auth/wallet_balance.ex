defmodule GateioAuth.WalletMigration do
  use Ecto.Schema
  import Ecto.Changeset

  # @primary_key {:id, :binary_id, autogenerate: true}
  schema "gateio_wallet_balance" do
    field :spot, :map
    field :delivery, :map
    field :finance, :map
    field :futures, :map
    field :margin, :map
    field :options, :map
    field :payment, :map
    field :pilot, :map
    field :quant, :map
    field :total_amount, :decimal
    field :total_borrowed, :decimal
    field :total_currency, :string
    field :total_unrealised_pnl, :decimal

  end

  @doc false
  def changeset(gateio_wallet_balance, attrs) do
    gateio_wallet_balance
    |> cast(attrs, [:spot, :delivery, :finance, :futures, :margin, :options, :payment, :pilot, :quant, :total_amount, :total_borrowed, :total_currency, :total_unrealised_pnl])
  end

end




# defmodule GateioAuth.WalletMigration.Delivery do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(delivery, attrs) do
#     delivery
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end


# defmodule GateioAuth.WalletMigration.Details do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(details, attrs) do
#     details
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end


# defmodule GateioAuth.WalletMigration.Finance do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(finance, attrs) do
#     finance
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end


# defmodule GateioAuth.WalletMigration.Futures do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(futures, attrs) do
#     futures
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end

# defmodule GateioAuth.WalletMigration.Margin do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(margin, attrs) do
#     margin
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end

# defmodule GateioAuth.WalletMigration.Options do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(options, attrs) do
#     options
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end

# defmodule GateioAuth.WalletMigration.Payment do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(payment, attrs) do
#     payment
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end

# defmodule GateioAuth.WalletMigration.Pilot do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(pilot, attrs) do
#     pilot
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end

# defmodule GateioAuth.WalletMigration.Quant do
#   use Ecto.Schema
#   import Ecto.Changeset

#   embedded_schema do
#     field :amount, :decimal
#     field :currency, :string
#     field :unrealised_pnl, :decimal
#   end

#   def changeset(quant, attrs) do
#     quant
#     |> cast(attrs, [:amount, :currency, :unrealised_pnl])
#     |> validate_required([:amount, :currency, :unrealised_pnl])
#   end
# end





# Repeat for Finance, Futures, Margin, Options, Payment, Pilot, Quant
