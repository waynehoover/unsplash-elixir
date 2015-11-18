defmodule Unsplash do
  alias Unsplash.ResultStream
  alias Unsplash.Api

  #GET /me
  def me do
    ResultStream.new("/me")
  end

  #PUT /me
  # username  Username.
  # first_name  First name.
  # last_name Last name.
  # email Email.
  # url Portfolio/personal URL.
  # location  Location.
  # bio About/bio.
  # instagram_username  Instagram username.
  def update_me(opts \\ []) do
    params = opts |> Keyword.take([:username, :first_name, :last_name, :email, :url, :location, :bio, :instagram_username])
    Api.put!("/me", params)
  end

  #GET /users/:username
  def users(username) do
    ResultStream.new("/users/#{username}")
  end

  #GET /users/:username/photos
  def users(username, 'photos') do
    ResultStream.new("/users/#{username}/photos")
  end

  #GET /users/:username/likes
  # page Page number to retrieve. (Optional; default: 1)
  # per_page  Number of items per page. (Optional; default: 10)
  def users(username, 'likes') do
    ResultStream.new("/users/#{username}/likes")
  end

  #GET /photos
  def photos do
    ResultStream.new("/photos")
  end

  def photos(_, opts \\ [])

  #GET /photos/search
  # query  Search terms.
  # category  Category ID(‘s) to filter search. If multiple, comma-separated.
  # page  Page number to retrieve. (Optional; default: 1)
  # per_page  Number of items per page. (Optional; default: 10)
  def photos(:search, opts) do
    params = opts |> Keyword.take([:query, :category]) |> URI.encode_query
    ResultStream.new("/photos/search?#{params}")
  end

  #GET /photos/random
  # category Category ID(‘s) to filter selection. If multiple, comma-separated.
  # featured  Limit selection to featured photos.
  # username  Limit selection to a single user.
  # query Limit selection to photos matching a search term.
  # w Image width in pixels.
  # h Image height in pixels.
  def photos(:random, opts) do
    params = opts |> Keyword.take([:category, :featured, :username, :query, :w, :h]) |> URI.encode_query
    ResultStream.new("/photos/random?#{params}")
  end

  #GET /photos/:id
  # w Image width in pixels.
  # h Image height in pixels.
  # rect 4 comma-separated integers representing x, y, width, height of the cropped rectangle.
  def photos(id, opts) when is_binary(id) do
    params = opts |> Keyword.take([:w, :h, :rect]) |> URI.encode_query
    ResultStream.new("/photos/#{id}?#{params}")
  end

  #POST /photos/:id/like
  def photos(id, :like) when is_binary(id) do
    Api.post!("/photos/#{id}/like")
  end

  # #DELETE /photos/:id/like
  def photos(id, :unlike) when is_binary(id) do
    Api.delete!("/photos/#{id}/like")
  end

  #POST /photos
  # photo The photo to be uploaded.
  #
  # ToDo!
  def upload_photo(photo) do
    Api.post!("/photos", photo)
  end

  #GET /categories
  def categories do
    ResultStream.new("/categories")
  end

  #GET /categories/:id
  def categories(id) do
    ResultStream.new("/categories/#{id}")
  end

  #GET /categories/:id/photos
  def categories(id, :photos) do
    ResultStream.new("/categories/#{id}/photos")
  end

  #GET /curated_batches
  def curated_batches do
    ResultStream.new("/curated_batches")
  end

  #GET /curated_batches/:id
  def curated_batches(id) do
    ResultStream.new("/curated_batches/#{id}")
  end

  #GET /curated_batch/:id/photos
  def curated_batches(id, :photos) do
    ResultStream.new("/curated_batches/#{id}/photos")
  end

  #GET /stats/total
  def stats do
    ResultStream.new("/stats/total")
  end
end
