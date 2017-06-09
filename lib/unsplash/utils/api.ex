defmodule Unsplash.Utils.API do
  alias Unsplash.Utils.OAuth

  @moduledoc false
  @doc false
  use HTTPoison.Base

  @endpoint "https://api.unsplash.com"

  def endpoint do
    @endpoint
  end

  defp process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    headers = headers ++ [
      {"Accept-Version", "v1"},
      {"Authorization", "Client-ID #{application_id}"},
      {"Content-type", "application/json; charset=utf-8"}
    ]

    if OAuth.get_access_token do
      headers ++ [{"Authorization", "Bearer #{OAuth.get_access_token}"}]
    else
      headers
    end
  end

  defp application_id do
    Application.get_env(:unsplash, :application_id)
  end

end
