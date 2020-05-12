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