# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hn_comments_game,
  ecto_repos: [HnCommentsGame.Repo]

# Configures the endpoint
config :hn_comments_game, HnCommentsGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JkunEDYlSom2TldDG15emKV1EPiKS/IzYWQkj+y0VFDZLCQJjaf4+I7aXSMZ8FEZ",
  render_errors: [view: HnCommentsGameWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HnCommentsGame.PubSub,
  live_view: [signing_salt: "TU+e7Yk2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
