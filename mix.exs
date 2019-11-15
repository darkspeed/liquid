defmodule Liquid.MixProject do
  use Mix.Project

  def project do
    [
      app: :liquid,
      version: "0.1.0",
      description: """
      Pluggable proxy obfuscation designed to counteract
      deep packet inspection and advanced fingerprinting techniques.
      """,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Liquid, []},
      extra_applications: [:logger, :plug_cowboy]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
