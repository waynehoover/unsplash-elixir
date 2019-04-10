defmodule Unsplash.Photos do
  @moduledoc ~S"""
  ## /photos
  All /photos/* api endpoints
  """

  alias Unsplash.Utils.{API, ResultStream}

  @doc ~S"""
  GET /photos

  Args:
    * `opts` - Keyword list of options
  Options:
    * `order_by` - How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def all(opts \\ []) do
    ResultStream.new("/photos", opts)
  end

  @doc ~S"""
    GET /photos/curated

  Args:
    * `opts` - Keyword list of options
  Options:
    * `order_by` -  How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
  """
  def curated(opts \\ []) do
    ResultStream.new("/photos/curated", opts)
  end

  @doc ~S"""
  GET /photos/:id

  Returns instances of dynamically resizable image URLs.

  Args:
    * `id` - the photo id
  """
  def get(id) do
    ResultStream.new("/photos/#{id}")
  end

  @doc ~S"""
  GET /photos/random

  Returns instances of dynamically resizable image URLs.

  Args:
    * `opts` - Keyword list of options
  Options:
    * `collections` - Public collection ID(‘s) to filter selection. If multiple, comma-separated
    * `featured` - Limit selection to featured photos.
    * `username` - Limit selection to a single user.
    * `query` - Limit selection to photos matching a search term.
    * `orientation` - Filter search results by photo orientation. Valid values are landscape, portrait, and squarish.
    * `count` - The number of photos to return. (Default: 1; max: 30)
  """
  def random(opts \\ []) do
    ResultStream.new("/photos/random", opts)
  end

  @doc ~S"""
  POST /photos/:id/statistics

  Args
    * `id` - The public id of the photo. Required.
    * `opts` - Keyword list of options
  Options:
    * `resolution` - The frequency of the stats. (Optional; default: “days”)
    * `quantity` - The amount of for each stat. (Optional; default: 30)
  """
  def statistics(id, opts \\ []) do
    ResultStream.new("/photos/#{id}/statistics", opts)
  end

  @doc ~S"""
  GET /photos/:id/download

  Args:
    * `id` - the photo id
  """
  def download_link(id) do
    API.get!("/photos/#{id}/download").body |> Jason.decode!()
  end

  @doc ~S"""
  PUT /photos/:id

  Args:
    * `id` - The photo’s ID. Required.
    * `opts` - Keyword list of options
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
    optional_params = [
      location: [:latitude, :longitude, :name, :city, :country, :confidential],
      exif: [
        :make,
        :model,
        :exposure_time,
        :exposure_value,
        :aperture_value,
        :focal_length,
        :iso_speed_ratings
      ]
    ]

    params =
      opts
      |> Keyword.take(optional_params)
      |> Enum.into(%{})
      |> Jason.encode!()

    API.put!("/photos/#{id}", params).body |> Jason.decode!()
  end

  @doc ~S"""
  POST /photos/:id/like

  Args:
    * `id` - the photo id

  Requires the `write_likes` scope
  """
  def like(id) do
    API.post!("/photos/#{id}/like", []).body |> Jason.decode!()
  end

  @doc ~S"""
  DELETE /photos/:id/like

  Args:
    * `id` - the photo id
  """
  def unlike(id) do
    API.delete!("/photos/#{id}/like").body |> Jason.decode!()
  end
end
