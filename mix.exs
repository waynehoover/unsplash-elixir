defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unsplash,
      version: "1.1.0",
      elixir: "~> 1.6",
      description: "Unsplash API for Elixir",
      source_url: "https://github.com/waynehoover/unsplash-elixir",
      homepage_url: "https://github.com/waynehoover/unsplash-elixir",
      package: package(),
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      applications: [:logger, :httpoison, :oauth2],
      mod: {Unsplash, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.0"},
      {:jason, "~> 1.1"},
      {:oauth2, "~> 1.0.0"},
      {:earmark, "~> 1.3.2", only: :dev},
      {:ex_doc, "~> 0.20.1", only: :dev, runtime: false},
      {:exvcr, "~> 0.10.3", only: [:test, :dev]},
      {:credo, "~> 1.0.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10.6", only: :test}
    ]
  end

  defp docs do
    [
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: ["waynehoover"],
      licenses: ["MIT"],
      links: %{
        "github" => "https://github.com/waynehoover/unsplash-elixir",
        "docs" => "http://hexdocs.pm/unsplash/"
      }
    ]
  end
end
