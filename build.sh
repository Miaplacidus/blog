#!/usr/bin/env bash
# Install Pandoc
wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz
tar xvzf pandoc-2.7.3-linux.tar.gz --strip-components 1 -C ~/project/src
rm pandoc-2.7.3-linux.tar.gz 

# Add Pandoc command
alias pandoc="~/project/src/bin/pandoc"
alias pandoc-citeproc="~/project/src/bin/pandoc-citeproc"

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite
