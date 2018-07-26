defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unsplash,
      version: "1.0.0",
      elixir: "~> 1.6",
      description: "Unsplash API in Elixir",
      source_url: "https://github.com/waynehoover/unsplash-elixir",
      homepage_url: "https://github.com/waynehoover/unsplash-elixir",
      package: package(),
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
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
      {:httpoison, "~> 1.2.0"},
      {:poison, "~> 3.1.0"},
      {:oauth2, "~> 0.9.1"},
      {:earmark, "~> 1.2.5", only: :dev},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:exvcr, "~> 0.10.2", only: [:test, :dev]},
      {:credo, "~> 0.9.3", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.9.1", only: :test}
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
