defmodule GateioAuth.Repo do
  use Ecto.Repo,
    otp_app: :gateio_auth,
    adapter: Ecto.Adapters.Postgres
end
