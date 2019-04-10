defmodule Unsplash do
  @moduledoc ~S"""
  # An Unslpash API client for Elixir

  Example Usage:

  `Unsplash.Photos.search(query: "Austin", catgeroy: "2") |> Enum.take(1)`
  """
  def start(_type, _args) do
    Unsplash.Utils.OAuth.start()
  end
end
