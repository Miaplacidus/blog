use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :blog, BlogWeb.Endpoint,
  secret_key_base: "${SECRET_KEY_BASE}" 

# Configure your database
config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  pool_size: 1,
  ssl: true
