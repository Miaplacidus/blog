defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [
      app: :blog,
      version: "0.0.1",
      elixir: "~> 1.4",
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
      extra_applications: [:logger, :runtime_tools, :timex, :guardian, :ueberauth_google, :scrivener_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cloudex, "~> 1.1"},
      {:cowboy, "~> 1.0"},
      {:espec, "~> 1.4.6", only: :test},
      {:distillery, "~> 1.5", runtime: false},
      {:faker, "~> 0.9", only: [:test, :dev]},
      {:floki, "~> 0.20.0"},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 1.0"},
      {:httpoison, "~> 1.0"},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_slime, "~> 0.9.0"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 1.3"},
      {:timex, "~> 3.1"},
      {:ueberauth, "~> 0.4"},
      {:ueberauth_google, "~> 0.7.0"}
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
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
