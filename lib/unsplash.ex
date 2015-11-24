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

  Optional params as keyword list:
  username  Username.
  first_name  First name.
  last_name Last name.
  email Email.
  url Portfolio/personal URL.
  location  Location.
  bio About/bio.
  instagram_username  Instagram username.

  Requires `write_user` scope
  """
  def update_me(opts \\ []) do
    params = opts |> Keyword.take([:username, :first_name, :last_name, :email, :url, :location, :bio, :instagram_username])
    Api.put!("/me", params)
  end

  @doc ~S"""
  GET /users/:username

  Required param is the username.
  """
  def users(username) do
    ResultStream.new("/users/#{username}")
  end

  @doc ~S"""
  GET /users/:username/photos

  Required param is the username.
  """
  def users(username, 'photos') do
    ResultStream.new("/users/#{username}/photos")
  end

  @doc ~S"""
  GET /users/:username/likes

  Required param is the username.
  """
  def users(username, 'likes') do
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

  Optional params as keyword list:
  query  Search terms.
  category  Category ID(‘s) to filter search. If multiple, comma-separated.
  """
  def photos(:search, opts) do
    params = opts |> Keyword.take([:query, :category]) |> URI.encode_query
    ResultStream.new("/photos/search?#{params}")
  end

  @doc ~S"""
  GET /photos/random

  Optional params as keyword list:
  category Category ID(‘s) to filter selection. If multiple, comma-separated.
  featured  Limit selection to featured photos.
  username  Limit selection to a single user.
  query Limit selection to photos matching a search term.
  w Image width in pixels.
  h Image height in pixels.
  """
  def photos(:random, opts) do
    params = opts |> Keyword.take([:category, :featured, :username, :query, :w, :h]) |> URI.encode_query
    ResultStream.new("/photos/random?#{params}")
  end

  @doc ~S"""
  GET /photos/:id

  Required param is the photo id

  Optional params as keyword list:
  w Image width in pixels.
  h Image height in pixels.
  rect 4 comma-separated integers representing x, y, width, height of the cropped rectangle.
  """
  def photos(id, opts) when is_binary(id) do
    params = opts |> Keyword.take([:w, :h, :rect]) |> URI.encode_query
    ResultStream.new("/photos/#{id}?#{params}")
  end

  @doc ~S"""
  POST /photos/:id/like

  Required param is the photo id
  """
  def photos(id, :like) when is_binary(id) do
    Api.post!("/photos/#{id}/like")
  end

  @doc ~S"""
  DELETE /photos/:id/like

  Required param is the photo id
  """
  def photos(id, :unlike) when is_binary(id) do
    Api.delete!("/photos/#{id}/like")
  end

  @doc ~S"""
  ToDo: Not Implemented
  POST /photos

  required param:
  photo The photo to be uploaded.
  """
  def upload_photo(photo) do
    Api.post!("/photos", photo)
  end

  @doc ~S"""
  GET /categories
  """
  def categories do
    ResultStream.new("/categories")
  end

  @doc ~S"""
  GET /categories/:id

  Required param is the category id
  """
  def categories(id) do
    ResultStream.new("/categories/#{id}")
  end

  @doc ~S"""
  GET /categories/:id/photos

  Required param is the category id
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

  Required param is the curated batch id
  """
  def curated_batches(id) do
    ResultStream.new("/curated_batches/#{id}")
  end

  @doc ~S"""
  GET /curated_batch/:id/photos

  Required param is the curated batch id
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
