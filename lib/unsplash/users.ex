defmodule Unsplash.Users do
  @moduledoc ~S"""
  API endpoints for current-user and users
  """

  alias Unsplash.Utils.{API, ResultStream}

  @doc ~S"""
  GET /users/:username

  The image URLs returned for the user’s profile image are instances of dynamically resizable image URLs.

  Args:
    * `username` - the username string
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
    API.get!("/users/#{username}/portfolio").body |> Jason.decode!()
  end

  @doc ~S"""
  GET /users/:username/photos

  Args:
    * `username` The user’s username. Required.
    * `opts` keyword list of optional params

  Options:
    * `page` Page number to retrieve. (Optional; default: 1)
    * `per_page` Number of items per page. (Optional; default: 10)
    * `order_by` How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
    * `stats` how the stats for each user’s photo. (Optional; default: false)
    * `resolution` The frequency of the stats. (Optional; default: “days”)
    * `quantity` The amount of for each stat. (Optional; default: 30)
  """
  def photos(username, opts \\ []) do
    ResultStream.new("/users/#{username}/photos", opts)
  end

  @doc ~S"""
  GET /users/:username/likes

  Args:
    * `username` the username string
    * `opts` keyword list of optional params

  Options:
    * `order_by` How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def likes(username, opts \\ []) do
    ResultStream.new("/users/#{username}/likes", opts)
  end

  @doc ~S"""
  GET /users/:username/collections

  Args:
    * `username` - The user’s username. Required
  """
  def collections(username, opts \\ []) do
    ResultStream.new("/users/#{username}/collections", opts)
  end

  @doc ~S"""
  GET /users/:username/statistics

  Args:
    * `username` -The user’s username. Required.
    * `opts` keyword list of optional params

  Options:
    * `resolution`  -The frequency of the stats. (Optional; default: “days”)
    * `quantity` -The amount of for each stat. (Optional; default: 30)
  """
  def statistics(username, opts \\ []) do
    ResultStream.new("/users/#{username}/statistics", opts)
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
    * `opts` keyword list of optional params

  Options:
    * `username` - Username.
    * `first_name` - First name.
    * `last_name` - Last name.
    * `email` - Email.
    * `url` - Portfolio/personal URL.
    * `location` - Location.
    * `bio` - About/bio.
    * `instagram_username` - Instagram username.

  Requires `write_user` scope
  """
  def update_me(opts \\ []) do
    params =
      opts
      |> Keyword.take([
        :username,
        :first_name,
        :last_name,
        :email,
        :url,
        :location,
        :bio,
        :instagram_username
      ])
      |> Enum.into(%{})
      |> Jason.encode!()

    API.put!("/me", params).body |> Jason.decode!()
  end
end
