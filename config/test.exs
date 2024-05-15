import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twilio_app, TwilioAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6u3HXbMCkjfKdpAOYj5a3OB6HZGYytfqwGaQwX6r/Su8nLo0jMIhsV1yULJ1FDIL",
  server: false

# In test we don't send emails.
config :twilio_app, TwilioApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true
