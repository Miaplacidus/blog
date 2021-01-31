defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [
      app: :blog,
      version: "0.1.0",
      elixir: "~> 1.9.1",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Blog.Application, []},
      extra_applications: [:logger, :cloudex, :httpoison, :runtime_tools, :timex, :guardian, :ueberauth_google, :scrivener_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cloudex, "~> 1.4"},
      {:ecto_sql, "~> 3.1"},
      {:espec, "~> 1.4.6", only: :test},
      {:faker, "~> 0.12.0", only: [:test, :dev]},
      {:floki, "~> 0.20.0"},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 2.1.1"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.1"},
      {:phoenix, "~> 1.4.9"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.13.3"},
      {:phoenix_live_reload, "~> 1.2.4", only: :dev},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_slime, "~> 0.12.0"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:rambo, "~> 0.3.2"},
      {:scrivener_ecto, "~> 2.2.0"},
      {:timex, "~> 3.6"},
      {:ueberauth, "~> 0.6.3"},
      {:ueberauth_google, "~> 0.9"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
