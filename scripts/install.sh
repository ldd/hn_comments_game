#!/bin/bash

# install elixir
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install esl-erlang -y
sudo apt-get install elixir -y
sudo apt install inotify-tools -y
mix local.hex --force
mix local.rebar --force


# install node
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs -y

# install postgres
sudo apt install postgresql -y

# project setup
cd hn_comments_game
cd assets && npm install && cd ..
mix deps.get
sudo -u postgres ./scripts/reset_database.sh
./scripts/deploy.sh

# https://elixirforum.com/t/whats-the-best-way-to-serve-restricted-ports-e-g-80-443-with-phoenix/2841
sudo setcap 'cap_net_bind_service=+ep' /usr/lib/erlang/erts-10.7.1/bin/beam.smp
sudo setcap 'cap_net_bind_service=+ep' _build/prod/rel/hn_comments_game/erts*/bin/beam.smp