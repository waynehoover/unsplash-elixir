defmodule Unsplash.Utils.ResultStream do
  alias Unsplash.Utils.API

  @doc ~S"""
  Generates the URI. Given base URI optional_params, then given params.

  ## Examples
    iex> Unsplash.Utils.ResultStream.build_uri('/users/wayneph/photos', [:per_page], per_page: 30, not_valid: 'yes')
    "/users/wayneph/photos?per_page=30"
  """
  def build_uri(url, optional_params, given_params) do
    query = given_params |> Keyword.take(optional_params) |> URI.encode_query
    "#{url}?#{query}"
  end

  def new(url, given_params, optional_params) do
    build_uri(url, given_params, optional_params) |> new
  end

  def new(url) do
    Stream.resource(
      fn -> fetch_page(url) end,
      &process_page/1,
      fn _ -> true end
    )
  end

  defp fetch_page(url) do
    response = API.get!(url)
    items = Poison.decode!(response.body)
    links = response.headers |> Enum.into(%{}) |> Map.get("Link") |> parse_links

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
      short_url = String.replace(url, API.endpoint, "")

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
