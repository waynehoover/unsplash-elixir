defmodule Unsplash.Collections do
  alias Unsplash.Utils.{API, ResultStream}

  @doc ~S"""
  GET /collections
  """
  def all(opts \\ []) do
    params = [:page, :per_page]
    ResultStream.new("/collections", params, opts)
  end

  @doc ~S"""
    GET /collections/featured
  """
  def featured(opts \\ []) do
    params = [:page, :per_page]
    ResultStream.new("/collections/featured", params, opts)
  end

  @doc ~S"""
    GET /collections/curated
  """
  def curated(opts \\ []) do
    params = [:page, :per_page]
    ResultStream.new("/collections/curated", params, opts)
  end

  @doc ~S"""
  GET /collections/:id

  Args:
    * `id` - The collections ID
  """
  def get(id) do
    ResultStream.new("/collections/#{id}")
  end

  @doc ~S"""
  GET /collections/curated/:id

  Args:
    * `id` - The collections ID
  """
  def get_curated(id) do
    ResultStream.new("/collections/curated/#{id}")
  end

  @doc ~S"""
  GET /collections/:id/related

  Args:
    * `id` - The collections ID
  """
  def get_related(id) do
    ResultStream.new("/collections/#{id}/related")
  end

  @doc ~S"""
  GET /collections/:id/photos

  Args:
    * `id` - The collections ID
  """
  def photos(id) do
    ResultStream.new("/collections/#{id}/photos")
  end

  @doc ~S"""
  GET /collections/curated/:id/photos

  Args:
    * `id` - The collections ID
  """
  def curated_photos(id) do
    ResultStream.new("/collections/curated/#{id}/photos")
  end

  @doc ~S"""
  GET /collections/:id/related

  Args:
    * `id` - The collections ID
  """
  def related_photos(id) do
    ResultStream.new("/collections/#{id}/related")
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
  def create(opts \\ []) do
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
  def update(id, opts \\ []) do
    params = opts |> Keyword.take([:title, :description, :private])
                  |> Enum.into(%{})
                  |> Poison.encode!
    API.put!("/collections/#{id}", params).body |> Poison.decode!
  end

  @doc ~S"""
  DELETE /collections/:id

  Requires `write_collections` scope
  """
  def delete(id) do
    API.delete!("/collections/#{id}").body |> Poison.decode!
  end

  @doc ~S"""
  POST /collections/:collection_id/add

  Args:
    * `collection_id` - The collection’s ID. Required.
    * `photo_id` - The photo’s ID. Required.

  Requires `write_collections` scope
  """
  def add_photo(id, photo_id) do
    params = %{photo_id: photo_id} |> Poison.decode!
    API.post!("/collections/#{id}/add", params).body |> Poison.decode!
  end

  @doc ~S"""
  DELETE /collections/:collection_id/add

  Args:
    * `collection_id` - The collection’s ID. Required.
    * `photo_id` - The photo’s ID. Required.

  Requires `write_collections` scope
  """
  def remove_photo(id, photo_id) do
    params = %{photo_id: photo_id} |> Poison.decode!
    API.delete!("/collections/#{id}/remove", params).body |> Poison.decode!
  end
end
