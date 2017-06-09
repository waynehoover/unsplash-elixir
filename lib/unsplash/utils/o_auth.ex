defmodule Unsplash.Utils.OAuth do
  @moduledoc ~S"""
  ## Authorization
  `Unsplash.OAuth.authorize_url! scope: "public read_user write_user read_photos write_photos write_likes read_collections write_collections"
  `Unsplash.OAuth.authorize!(code: auth_code_from_the_callback_above)`

  Now all calls will be authorized.
  """

  @doc false
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

  @doc ~S"""
  Generates the authorization url which then authenticates with the user.

  The `scope` option should be space seperated string of requested scopes.

  Possible scopes:
    * `public` Default. Read public data.
    * `read_user` Access user’s private data.
    * `write_user`  Update the user’s profile.
    * `read_photos` Read private data from the user’s photos.
    * `write_photos`  Upload photos on the user’s behalf.
    * `write_likes` Like or unlike a photo on the user’s behalf
    * `read_collections`  View a user’s private collections.
    * `write_collections` Create and update a user’s collections.

  ## Examples
    iex> url = Unsplash.Utils.OAuth.authorize_url! scope: "public read_user write_user read_photos write_photos write_likes read_collections write_collections"
    iex> is_binary(url)
    true

  """
  def authorize_url!(params \\ []) do
    client()
    |> OAuth2.Client.authorize_url!(params)
  end

  # Get and store the token
  def authorize!(params \\ [], headers \\ [], options \\ []) do
    client()
    |> OAuth2.Client.get_token!(params, headers, options)
    |> store_token
  end

  # Callbacks
  def authorize_url(client, params) do
    client
    |> OAuth2.Strategy.AuthCode.authorize_url(params)
  end

  def get_token(client, params, headers) do
    client
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  ## Token storage in an Agent
  def start do
    Agent.start_link fn -> %{} end, name: __MODULE__
  end

  def store_token(token) do
    Agent.update(__MODULE__, &Map.put(&1, :token, token))
    token
  end

  defdelegate un_authorize!, to: __MODULE__, as: :remove_token
  def remove_token do
    Agent.update(__MODULE__,  &Map.put(&1, :token, nil))
  end

  #Get the Oauth.AccessToken struct from the agent
  def get_access_token do
    Agent.get(__MODULE__, &Map.get(&1, :token))
    |> process_token
  end

  #If the token is expired refresh it.
  def process_token(token) when is_map(token) do
    # if OAuth2.AccessToken.expired?(token) do
    #   token = token |> OAuth2.AccessToken.refresh! |> store_token
    # end
    token.access_token
  end
  # all other cases
  def process_token(_token), do: nil

end

