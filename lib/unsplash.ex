defmodule Unsplash do
  @moduledoc ~S"""
  # The Unslpash API in Elixir

  ## Pagination
  Those API results that are paginated will return a Stream in which you can resolve by using any Enum function. You can also pass in `per_page` and `page` keywords if you would like to do pagination manually. Max per_page is 30.
  """

  alias Unsplash.Utils.{API, ResultStream}

  def start(_type, _args) do
    Unsplash.Utils.OAuth.start
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

  # Default options for all below
  def photos(_, opts \\ [])

  @doc ~S"""
  GET /photos

  Args:
    * `order_by` - How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def photos(:all, opts) do
    params = build_params([:per_page, :page, :order_by], opts)
    ResultStream.new("/photos?#{params}")
  end

  @doc ~S"""
  GET /photos/search

  Args:
    * `opts` - Keyword list of options

  Options:
    * `query` - Search terms.
    * `category` - Category ID(‘s) to filter search. If multiple, comma-separated.
  """
  def photos(:search, opts) do
    params = build_params([:query, :category, :per_page, :page], opts)
    ResultStream.new("/photos/search?#{params}")
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
    params = build_params([:category, :featured, :username, :query, :w, :h, :per_page, :page], opts)
    ResultStream.new("/photos/random?#{params}")
  end

  @doc ~S"""
  POST /photos/:id/like

  Args:
    * `id` - the photo id

  Requires the `write_likes` scope
  """
  def photos(id, :like) when is_binary(id) do
    API.post!("/photos/#{id}/like", []).body
    |> Poison.decode!
  end

  @doc ~S"""
  DELETE /photos/:id/like

  Args:
    * `id` - the photo id
  """
  def photos(id, :unlike) when is_binary(id) do
    result = API.delete!("/photos/#{id}/like").body
    if result != "" do
      result |> Poison.decode!
    else
      []
    end
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
    params = build_params([:w, :h, :rect, :per_page, :page], opts)
    ResultStream.new("/photos/#{id}?#{params}")
  end

  @doc ~S"""
  POST /photos

  Args:
    * `photo` - the path of the photo to be uploaded.

  Requires the `write_photos` scope

  Thanks to https://stackoverflow.com/q/33557133/ for the solution on how to upload named files.
  """
  def upload_photo(photo) do
    API.post!("/photos", {:multipart, [{:file, photo, { ["form-data"], [name: "\"photo\"", filename: "\"#{photo}\""]},[]}]}, [], [recv_timeout: 30000]).body
    |> Poison.decode!
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
  def categories(id, :photos, opts \\ []) do
    params = build_params([:per_page, :page], opts)
    ResultStream.new("/categories/#{id}/photos?#{params}")
  end

  @doc ~S"""
  GET /collections
  """
  def collections do
    ResultStream.new("/collections")
  end

  @doc ~S"""
    GET /collections/curated
  """
  def curated_collections do
    ResultStream.new("/collections/curated")
  end

  @doc ~S"""
  GET /collections/:id

  Args:
    * `id` - The collections ID
  """
  def collections(id) do
    ResultStream.new("/collections/#{id}")
  end

  @doc ~S"""
  GET /collections/curated/:id

  Args:
    * `id` - The collections ID
  """
  def curated_collections(id) do
    ResultStream.new("/collections/curated/#{id}")
  end

  @doc ~S"""
  GET /collections/:id/photos

  Args:
    * `id` - The collections ID
  """
  def collections(id, :photos) do
    ResultStream.new("/collections/#{id}/photos")
  end


  @doc ~S"""
  GET /collections/:id/photos

  Args:
    * `id` - The collections ID
  """
  def curated_collections(id, :photos) do
    ResultStream.new("/collections/currated/#{id}/photos")
  end

  @doc ~S"""
  POST /collections

  Args:
    * `opts` - Keyword list of options

  Options:
    * `title` - The title of the collection. (Required.)
    * `description` - The collection’s description. (Optional.)
    * `private` - Whether to make this collection private. (Optional; default false).

  Requires `write_collections` scope
  """
  def create_collection(opts \\ []) do
    params = opts |> Keyword.take([:title, :description, :private])
                  |> Enum.into(%{})
                  |> Poison.encode!
    API.post!("/collections", params).body |> Poison.decode!
  end

  @doc ~S"""
  PUT /collections/:id

  Args:
    * `opts` - Keyword list of options

  Options:
    * `title` - The title of the collection. (Required.)
    * `description` - The collection’s description. (Optional.)
    * `private` - Whether to make this collection private. (Optional; default false).

  Requires `write_collections` scope
  """
  def update_collection(id, opts \\ []) do
    params = opts |> Keyword.take([:title, :description, :private])
                  |> Enum.into(%{})
                  |> Poison.encode!
    API.put!("/collections/#{id}", params).body |> Poison.decode!
  end


  @doc ~S"""
  DELETE /collections/:id

  Requires `write_collections` scope
  """
  def delete_collection(id) do
    API.delete!("/collections/#{id}").body |> Poison.decode!
  end

  @doc ~S"""
  POST /collections/:collection_id/add

  Args:
    * `collection_id` - The collection’s ID. Required.
    * `photo_id` - The photo’s ID. Required.

  Requires `write_collections` scope
  """
  def collection_add_photo(id, photo_id) do
    params = %{photo_id: photo_id} |> Poison.decode!
    API.post!("/collections/#{id}/add", params).body |> Poison.decode!
  end

  @doc ~S"""
  POST /collections/:collection_id/add

  Args:
    * `collection_id` - The collection’s ID. Required.
    * `photo_id` - The photo’s ID. Required.

  Requires `write_collections` scope
  """
  def collection_remove_photo(id, photo_id) do
    params = %{photo_id: photo_id} |> Poison.decode!
    API.delete!("/collections/#{id}/remove", params).body |> Poison.decode!
  end

  @doc ~S"""
  GET /stats/total
  """
  def stats do
    ResultStream.new("/stats/total")
  end

  def build_params(params, opts) do
    opts |> Keyword.take([:per_page, :page | params]) |> URI.encode_query
  end
end
