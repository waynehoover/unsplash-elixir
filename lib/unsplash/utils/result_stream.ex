defmodule Unsplash.Utils.ResultStream do
  @moduledoc ~S"""
  Utility functions for traversing api pagination by generating an elixir Stream to work on.
  """

  alias Unsplash.Utils.API

  def new(path, params) do
    %URI{path: path, query: URI.encode_query(params)}
    |> URI.to_string()
    |> new
  end

  def new(url) do
    Stream.resource(fn -> fetch_page(url) end, &process_page/1, fn _ -> true end)
  end

  defp fetch_page(url) do
    response = API.get!(url)
    items = Jason.decode!(response.body)
    links = response.headers |> Enum.into(%{}) |> Map.get("Link") |> parse_links

    {items, links["next"]}
  end

  def parse_links(nil) do
    %{}
  end

  def parse_links(links_string) do
    links_string
    |> String.split(", ")
    |> Enum.map(fn link ->
      [_, name] = Regex.run(~r{rel="([a-z]+)"}, link)
      [_, url] = Regex.run(~r{<([^>]+)>}, link)
      short_url = String.replace(url, API.endpoint(), "")

      {name, short_url}
    end)
    |> Enum.into(%{})
  end

  defp process_page({nil, nil}) do
    {:halt, nil}
  end

  defp process_page({nil, next_page_url}) do
    next_page_url
    |> fetch_page
    |> process_page
  end

  defp process_page({items, next_page_url}) do
    {items, {nil, next_page_url}}
  end
end
