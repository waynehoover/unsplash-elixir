defmodule Unsplash.ResultStream do
  alias Unsplash.Api

  # Can

  def new(url) do
    Stream.resource(
      fn -> fetch_page(url) end,
      &process_page/1,
      fn _ -> end
    )
  end

  defp fetch_page(url) do
    response = Api.get!(url)
    items = Poison.decode!(response.body)
    links = parse_links(response.headers["Link"])

    {items, links["next"]}
  end

  def parse_links(nil) do
    %{}
  end

  def parse_links(links_string) do
    links = String.split(links_string, ", ")

    Enum.map(links, fn link ->
      [_,name] = Regex.run(~r{rel="([a-z]+)"}, link)
      [_,url] = Regex.run(~r{<([^>]+)>}, link)
      short_url = String.replace(url, Api.endpoint, "")

      {name, short_url}
    end) |> Enum.into(%{})
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
