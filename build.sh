#!/usr/bin/env bash
# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

# Install Pandoc
wget https://github.com/jgm/pandoc/releases/download/2.5/pandoc-2.5-1-amd64.deb
sudo dpkg -i pandoc-2.5-1-amd64.deb
rm pandoc-2.5-1-amd64.deb