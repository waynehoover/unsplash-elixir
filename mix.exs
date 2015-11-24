defmodule Unsplash.Mixfile do
  use Mix.Project

  def project do
    [app: :unsplash,
     version: "0.0.1",
     elixir: "~> 1.1",
     description: "Unsplash API in Elixir",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [ applications: [:logger, :httpoison, :oauth2],
      mod: {Unsplash, []} ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"},
      {:oauth2, "~> 0.5"}
    ]
  end

  defp package do
    [
      maintainers: ["waynehoover"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/waynehoover/unsplash-elixir"}
    ]
  end
end
