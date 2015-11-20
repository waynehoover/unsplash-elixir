defmodule Unsplash.OAuth do
  use OAuth2.Strategy

  # Public API

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: application_id,
      client_secret: application_secret,
      redirect_uri: application_redirect_uri,
      site: "https://api.unsplash.com",
      authorize_url: "https://unsplash.com/oauth/authorize",
      token_url: "https://unsplash.com/oauth/token"
    ])
  end

  # Possible scopes.
  # public Default. Read public data.
  # read_user Access user’s private data.
  # write_user  Update the user’s profile.
  # read_photos Read private data from the user’s photos.
  # write_photos  Upload photos on the user’s behalf.
  # Need to replace for now because of OAuth param to_url
  def authorize_url!(params \\ []) do
    client
    |> OAuth2.Client.authorize_url!(params) |> String.replace("%2B","+")
  end

  def authorize!(auth_code) do
    OAuth2.Client.get_token!(client, code: auth_code)
    |> store_token
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  #ToDo Store token in a process, to be used to authenticate private calls
  def store_token(token) do

  end

  #ToDo retrieve the token storked above
  def retrieve_access_token do
    false
  end

  defp application_id do
    Application.get_env(:unsplash, :application_id)
  end
  defp application_secret do
    Application.get_env(:unsplash, :application_secret)
  end
  defp application_redirect_uri do
    Application.get_env(:unsplash, :application_redirect_uri)
  end
end

