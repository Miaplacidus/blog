import Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :blog, BlogWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true

# Configure your database
config :blog, Blog.Repo,
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PW"),
  database: System.get_env("DB_NAME"),
  adapter: Ecto.Adapters.Postgres,
  pool_size: 15,
  ssl: true