defmodule Unsplash.Photos do
  alias Unsplash.Utils.{API, ResultStream}

  @doc ~S"""
  GET /photos

  Args:
    * `order_by` - How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def all(opts \\ []) do
    params = [:per_page, :page, :order_by]
    ResultStream.new("/photos", params, opts)
  end

  @doc ~S"""
    GET /photos/curated
    Note: See the note on hotlinking.

    Args:
      'page' - Page number to retrieve. (Optional; default: 1)
      'per_page' - Number of items per page. (Optional; default: 10)
      'order_by' -  How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def curated(opts \\ []) do
    params = [:per_page, :page, :order_by]
    ResultStream.new("/photos/curated", params, opts)
  end

  @doc ~S"""
  GET /photos/:id

  Args:
    * `id` - the photo id

  Options:
    * `w` - Image width in pixels.
    * `h` - Image height in pixels.
    * `rect` - 4 comma-separated integers representing x, y, width, height of the cropped rectangle.
  """
  def get(id, opts \\ []) do
    params = [:w, :h, :rect, :per_page, :page]
    ResultStream.new("/photos/#{id}", params, opts)
  end

  @doc ~S"""
  GET /photos/random

  Args:
    * `opts` - Keyword list of options

  Options:
    * `collections` - Public collection ID(‘s) to filter selection. If multiple, comma-separated
    * `featured` - Limit selection to featured photos.
    * `username` - Limit selection to a single user.
    * `query` -Limit selection to photos matching a search term.
    * `w` -Image width in pixels.
    * `h` -Image height in pixels.
    * `orientation` -Filter search results by photo orientation. Valid values are landscape, portrait, and squarish.
    * `count` -The number of photos to return. (Default: 1; max: 30)
  """
  def random(opts \\ []) do
    params = [:collections, :featured, :username, :query, :w, :h, :orientation, :per_page, :page]
    ResultStream.new("/photos/random", params, opts)
  end

  @doc ~S"""
  POST /photos/:id/statistics

  Args
    * `id` - The public id of the photo. Required.

  Options:
    * `resolution` - The frequency of the stats. (Optional; default: “days”)
    * `quantity` - The amount of for each stat. (Optional; default: 30)
  """
  def statistics(id, opts \\ []) do
    params = [:resolution, :quantity]
    ResultStream.new("/photos/#{id}/statistics", params, opts)
  end

  @doc ~S"""
  GET /photos/:id/download

  Args:
    * `id` - the photo id
  """
  def download_link(id) do
    API.get!("/photos/#{id}/download").body |> Poison.decode!
  end

  @doc ~S"""
  PUT /photos/:id

  Args:
    * `id` - The photo’s ID. Required.

  Options:
    * location[latitude]  The photo location’s latitude (Optional)
    * location[longitude] The photo location’s longitude (Optional)
    * location[name]  The photo location’s name (Optional)
    * location[city]  The photo location’s city (Optional)
    * location[country] The photo location’s country (Optional)
    * location[confidential]  The photo location’s confidentiality (Optional)
    * exif[make]  Camera’s brand (Optional)
    * exif[model] Camera’s model (Optional)
    * exif[exposure_time] Camera’s exposure time (Optional)
    * exif[aperture_value]  Camera’s aperture value (Optional)
    * exif[focal_length]  Camera’s focal length (Optional)
    * exif[iso_speed_ratings] Camera’s iso (Optional)

  Requires the `write_photos` scope
  """
  def update(id, opts \\ []) do
    optional_params = [location: [:latitude, :longitude, :name, :city, :country, :confidential], exif: [:make, :model, :exposure_time, :exposure_value, :aperture_value, :focal_length, :iso_speed_ratings]]
    params = opts |> Keyword.take(optional_params)
                  |> Enum.into(%{})
                  |> Poison.encode!
    API.put!("/photos/#{id}", params).body |> Poison.decode!
  end

  @doc ~S"""
  POST /photos/:id/like

  Args:
    * `id` - the photo id

  Requires the `write_likes` scope
  """
  def like(id) do
    API.post!("/photos/#{id}/like", []).body |> Poison.decode!
  end

  @doc ~S"""
  DELETE /photos/:id/like

  Args:
    * `id` - the photo id
  """
  def unlike(id) do
    result = API.delete!("/photos/#{id}/like").body
    if result != "" do
      result |> Poison.decode!
    else
      []
    end
  end

end
