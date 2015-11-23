defmodule Unsplash.OAuth do
  use OAuth2.Strategy

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: Application.get_env(:unsplash, :application_id),
      client_secret: Application.get_env(:unsplash, :application_secret),
      redirect_uri: Application.get_env(:unsplash, :application_redirect_uri),
      site: "https://api.unsplash.com",
      authorize_url: "https://unsplash.com/oauth/authorize",
      token_url: "https://unsplash.com/oauth/token"
    ])
  end

  # Possible scopes.
  # public All public actions (default)
  # read_user Access user’s private data.
  # write_user  Update the user’s profile.
  # read_photos Read private data from the user’s photos.
  # write_photos  Upload photos on the user’s behalf.
  # scope param should be space seperated string, like `scope: "public read_user write_user read_photos write_photos"`
  def authorize_url!(params \\ []) do
    client
    |> OAuth2.Client.authorize_url!(params)
  end

  # Get and store the token
  def authorize!(params \\ [], headers \\ [], options \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, options)
    |> store_token
  end

  # Callbacks
  def authorize_url(client, params) do
    client
    |> OAuth2.Strategy.AuthCode.authorize_url(params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  # To move
  def store_token(token) do
    Agent.update(:unsplash, &Map.put(&1, :token, token))
  end

  #Get the Oauth.AccessToken struct from the agent, if its expired refresh it.
  def get_access_token do
    case Agent.get(:unsplash, &Map.get(&1, :token)) do
      nil -> nil
      token ->
        if OAuth2.AccessToken.expired?(token) do
          token = OAuth2.AccessToken.refresh!(token)
        end
        token.access_token
    end
  end

end

