defmodule Unsplash.Api do
  use HTTPoison.Base

  @endpoint "https://api.unsplash.com"

  def endpoint do
    @endpoint
  end

  defp process_url(url) do
    @endpoint <> url
  end

  defp process_request_headers(headers) do
    headers ++ [
      {"Accept-Version", "v1"},
      {"Authorization", "Client-ID #{application_id}"}
    ]
  end

  defp application_id do
    Application.get_env(:unsplash, :application_id)
  end

end
