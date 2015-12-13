defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unsplash,
      version: "0.3.0",
      elixir: "~> 1.1",
      description: "Unsplash API in Elixir",
      source_url: "https://github.com/waynehoover/unsplash-elixir",
      homepage_url: "https://github.com/waynehoover/unsplash-elixir",
      package: package,
      deps: deps,
      docs: docs
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
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"},
      {:oauth2, "~> 0.5"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:exvcr, "~> 0.6", only: [:dev, :test]}
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
      links: %{"github" => "https://github.com/waynehoover/unsplash-elixir", "docs" => "http://hexdocs.pm/unsplash/"}
    ]
  end
end
