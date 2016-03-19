defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unsplash,
      version: "0.4.0",
      elixir: "~> 1.2",
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
      {:httpoison, "0.8.1"},
      {:poison, "~> 1.5.2"},
      {:oauth2, "~> 0.6.0"},
      {:earmark, "~> 0.2.1", only: :dev},
      {:ex_doc, "~> 0.11.4", only: :dev},
      {:exvcr, "~> 0.7.1", only: [:test, :dev]}
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
