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

# cleanup
rm erlang-solutions_2.0_all.deb
rm nodesource_setup.sh

# project setup
cd hn_comments_game
cd assets && npm install && cd ..
mix deps.get
sudo -u postgres ./scripts/reset_database.sh
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs

# project deployment
./scripts/deploy.sh
