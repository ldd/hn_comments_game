#!/bin/bash
source .env

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm run deploy --prefix ./assets
mix phx.digest

# DB migrations
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix run priv/repo/seeds.exs

# Make a release
PORT=4001 MIX_ENV=prod mix release --overwrite

# https://elixirforum.com/t/whats-the-best-way-to-serve-restricted-ports-e-g-80-443-with-phoenix/2841
sudo setcap 'cap_net_bind_service=+ep' /usr/lib/erlang/erts-10.7.1/bin/beam.smp
sudo setcap 'cap_net_bind_service=+ep' _build/prod/rel/hn_comments_game/erts*/bin/beam.smp