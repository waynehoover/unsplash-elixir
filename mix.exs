defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unsplash,
      version: "1.0.0",
      elixir: "~> 1.4",
      description: "Unsplash API in Elixir",
      source_url: "https://github.com/waynehoover/unsplash-elixir",
      homepage_url: "https://github.com/waynehoover/unsplash-elixir",
      package: package(),
      deps: deps(),
      docs: docs()
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
      {:httpoison, "~> 0.11.2"},
      {:poison, "~> 3.1.0"},
      {:oauth2, "~> 0.9.1"},
      {:earmark, "~> 1.2.2", only: :dev},
      {:ex_doc, "~> 0.16.1", only: :dev},
      {:exvcr, "~> 0.8.10", only: [:test, :dev]}
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
