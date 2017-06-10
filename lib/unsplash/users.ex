defmodule Unsplash.Users do
  alias Unsplash.Utils.{API, ResultStream}
  @doc ~S"""
  GET /users/:username

  Args:
    * `username` - the username string
    * `w` - Profile image width in pixels.
    * `h` - Profile image height in pixels.
  """
  def get(username) do
    ResultStream.new("/users/#{username}")
  end

  @doc ~S"""
  GET /users/:username/portfolio

  Retrieve a single user’s portfolio link.

  Args:
    * `username` - The user’s username. Required.
  """
  def portfolio(username) do
    API.get!("/users/#{username}/portfolio").body |> Poison.decode!
  end

  @doc ~S"""
  GET /users/:username/photos

  Args:
    * `username` The user’s username. Required.
    * `page` Page number to retrieve. (Optional; default: 1)
    * `per_page` Number of items per page. (Optional; default: 10)
    * `order_by` How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
    * `stats` how the stats for each user’s photo. (Optional; default: false)
    * `resolution` The frequency of the stats. (Optional; default: “days”)
    * `quantity` The amount of for each stat. (Optional; default: 30)
  """
  def photos(username, opts \\ []) do
    optional_params = [:per_page, :page, :order_by, :stats, :resolution, :quantity]
    ResultStream.new("/users/#{username}/photos", optional_params, opts)
  end

  @doc ~S"""
  GET /users/:username/likes

  Args:
    * `username` - the username string
    * `order_by` - How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def likes(username, opts \\ []) do
    optional_params = [:per_page, :page, :order_by]
    ResultStream.new("/users/#{username}/likes", optional_params, opts)
  end

  @doc ~S"""
  GET /users/:username/collections

  Args:
    * `username` - The user’s username. Required
  """
  def collections(username, opts \\ []) do
    optional_params = [:per_page, :page]
    ResultStream.new("/users/#{username}/collections", optional_params, opts)
  end

  @doc ~S"""
  GET /users/:username/statistics

  Args:
    * `username` -The user’s username. Required.
    * `resolution`  -The frequency of the stats. (Optional; default: “days”)
    * `quantity` -The amount of for each stat. (Optional; default: 30)
  """
  def statistics(username, opts \\ []) do
    optional_params = [:resolution, :quantity]
    ResultStream.new("/users/#{username}/statistics", optional_params, opts)
  end

  @doc ~S"""
  GET /me

  Requires `read_user` scope
  """
  def me do
    ResultStream.new("/me")
  end

  @doc ~S"""
  PUT /me

  Args:
    * `opts` - Keyword list of options

  Options:
    * `username` - Username.
    * `first_name` - First name.
    * `last_name` -Last name.
    * `email` -Email.
    * `url` -Portfolio/personal URL.
    * `location` - Location.
    * `bio` -About/bio.
    * `instagram_username` - Instagram username.

  Requires `write_user` scope
  """
  def update_me(opts \\ []) do
    params = opts |> Keyword.take([:username, :first_name, :last_name, :email, :url, :location, :bio, :instagram_username])
                  |> Enum.into(%{})
                  |> Poison.encode!
     API.put!("/me", params).body |> Poison.decode!
  end

end
