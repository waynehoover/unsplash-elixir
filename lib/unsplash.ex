defmodule Unsplash do
  @moduledoc ~S"""
  # The Unslpash API in Elixir

  ## Pagination
  Those API results that are paginated will return a Stream in which you can resolve by using any Enum function.
  """

  alias Unsplash.ResultStream
  alias Unsplash.Api

  def start(_type, _args) do
    Unsplash.OAuth.start
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
    Api.put!("/me", params)
  end

  @doc ~S"""
  GET /users/:username

  Args:
    * `username` - the username string
  """
  def users(username) do
    ResultStream.new("/users/#{username}")
  end

  @doc ~S"""
  GET /users/:username/photos

  Args:
    * `username` - the username string
  """
  def users(username, :photos) do
    ResultStream.new("/users/#{username}/photos")
  end

  @doc ~S"""
  GET /users/:username/likes

  Args:
    * `username` - the username string
  """
  def users(username, :likes) do
    ResultStream.new("/users/#{username}/likes")
  end

  @doc ~S"""
  GET /photos
  """
  def photos do
    ResultStream.new("/photos")
  end

  def photos(_, opts \\ [])

  @doc ~S"""
  GET /photos/search

  Args:
    * `opts` - Keyword list of options

  Options:
    * `query` - Search terms.
    * `category` - Category ID(‘s) to filter search. If multiple, comma-separated.
  """
  def photos(:search, opts) do
    opts = Keyword.merge([per_page: 10], opts)
    params = opts |> Keyword.take([:query, :category, :per_page]) |> URI.encode_query
    ResultStream.new("/photos/search?#{params}") |> Enum.take(Keyword.fetch!(opts, :per_page))
  end

  @doc ~S"""
  GET /photos/random

  Args:
    * `opts` - Keyword list of options

  Options:
    * `category` - Category ID(‘s) to filter selection. If multiple, comma-separated.
    * `featured` -  Limit selection to featured photos.
    * `username` -  Limit selection to a single user.
    * `query` - Limit selection to photos matching a search term.
    * `w` - Image width in pixels.
    * `h` - Image height in pixels.
  """
  def photos(:random, opts) do
    params = opts |> Keyword.take([:category, :featured, :username, :query, :w, :h]) |> URI.encode_query
    ResultStream.new("/photos/random?#{params}")
  end

  @doc ~S"""
  GET /photos/:id

  Args:
    * `id` - the photo id
    * `opts` - Keyword list of options

  Options:
    * `w` - Image width in pixels.
    * `h` - Image height in pixels.
    * `rect` - 4 comma-separated integers representing x, y, width, height of the cropped rectangle.
  """
  def photos(id, opts) when is_binary(id) do
    params = opts |> Keyword.take([:w, :h, :rect]) |> URI.encode_query
    ResultStream.new("/photos/#{id}?#{params}")
  end

  @doc ~S"""
  POST /photos/:id/like

  Args:
    * `id` - the photo id

  Requires the `write_likes` scope
  """
  def photos(id, :like) when is_binary(id) do
    Api.post!("/photos/#{id}/like")
  end

  @doc ~S"""
  DELETE /photos/:id/like

  Args:
    * `id` - the photo id
  """
  def photos(id, :unlike) when is_binary(id) do
    Api.delete!("/photos/#{id}/like")
  end

  @doc ~S"""
  POST /photos

  Args:
    * `photo` - the path of the photo to be uploaded.

  Requires the `write_photos` scope
  """
  def upload_photo(photo) do
    Api.post!("/photos", {:file, photo})
  end

  @doc ~S"""
  GET /categories
  """
  def categories do
    ResultStream.new("/categories")
  end

  @doc ~S"""
  GET /categories/:id

  Args:
    * `id` - The category ID
  """
  def categories(id) do
    ResultStream.new("/categories/#{id}")
  end

  @doc ~S"""
  GET /categories/:id/photos

  Args:
    * `id` - The category ID
  """
  def categories(id, :photos) do
    ResultStream.new("/categories/#{id}/photos")
  end

  @doc ~S"""
  GET /curated_batches
  """
  def curated_batches do
    ResultStream.new("/curated_batches")
  end

  @doc ~S"""
  GET /curated_batches/:id

  Args:
    * `id` - The curated batch ID
  """
  def curated_batches(id) do
    ResultStream.new("/curated_batches/#{id}")
  end

  @doc ~S"""
  GET /curated_batch/:id/photos

  Args:
    * `id` - The curated batch ID
  """
  def curated_batches(id, :photos) do
    ResultStream.new("/curated_batches/#{id}/photos")
  end

  @doc ~S"""
  GET /stats/total
  """
  def stats do
    ResultStream.new("/stats/total")
  end
end
