defmodule Unsplash.Users do
  alias Unsplash.Utils.{API, ResultStream}

  #Todo: extact into ResultStream.
  def build_params(params, opts) do
    #[:per_page, :page] are redundant and being passed in by calling function already most of the time.
    opts |> Keyword.take([:per_page, :page | params]) |> URI.encode_query
  end

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
    params = build_params([:per_page, :page, :order_by, :stats, :resolution, :quantity], opts)
    ResultStream.new("/users/#{username}/photos?#{params}")
  end

  @doc ~S"""
  GET /users/:username/likes

  Args:
    * `username` - the username string
    * `order_by` - How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def likes(username, opts \\ []) do
    params = build_params([:per_page, :page, :order_by], opts)
    ResultStream.new("/users/#{username}/likes?#{params}")
  end

  @doc ~S"""
  GET /users/:username/collections

  Args:
    * `username` - The user’s username. Required
  """
  def collections(username, opts \\ []) do
    params = build_params([:per_page, :page], opts)
    ResultStream.new("/users/#{username}/collections?#{params}")
  end

  @doc ~S"""
  GET /users/:username/statistics

  Args:
    * `username` -The user’s username. Required.
    * `resolution`  -The frequency of the stats. (Optional; default: “days”)
    * `quantity` -The amount of for each stat. (Optional; default: 30)
  """
  def statistics(username, opts \\ []) do
    params = build_params([:resolution, :quantity], opts)
    ResultStream.new("/users/#{username}/statistics?#{params}")
  end

end
