import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gateio_auth, GateioAuthWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "mqlkmqZQCz4km8iNC/yhpAWpaS4J7pWHd5nofgmazGb6dfk+h4Ybj9PFZ251WJMA",
  server: false

# In test we don't send emails
config :gateio_auth, GateioAuth.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
