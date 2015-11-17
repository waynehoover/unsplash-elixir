defmodule Unsplash do
  alias Unsplash.ResultStream
  import Unsplash.Util

#GET /me

#PUT /me
# username  Username.
# first_name  First name.
# last_name Last name.
# email Email.
# url Portfolio/personal URL.
# location  Location.
# bio About/bio.
# instagram_username  Instagram username.

#GET /users/:username

#GET /users/:username/photos

#GET /users/:username/likes

  #GET /photos
  def photos do
    ResultStream.new("/photos")
  end

  #GET /photos/search/
  # query  Search terms.
  # category  Category ID(‘s) to filter search. If multiple, comma-separated.
  def photos('search', query) do
    params = URI.encode_query(query)
    ResultStream.new("/photos/search?#{params}")
  end

  #GET /photos/random
  # category Category ID(‘s) to filter selection. If multiple, comma-separated.
  # featured  Limit selection to featured photos.
  # username  Limit selection to a single user.
  # query Limit selection to photos matching a search term.
  # w Image width in pixels.
  # h Image height in pixels.
  def photos('random', query) do
    params = URI.encode_query(query)
    ResultStream.new("/photos/random?#{params}")
  end

  #GET /photos/:id
  # w Image width in pixels.
  # h Image height in pixels.
  # rect 4 comma-separated integers representing x, y, width, height of the cropped rectangle.

  #photos(id, w: 123, h: 123, rect: 1234)
  def photos(id, opts \\ []) when is_integer(id) do
    params = parse_options([:w, :h, :rect], opts) |> URI.encode_query
    ResultStream.new("/photos/#{id}?#{params}")
  end

#POST /photos
# photo The photo to be uploaded.

#POST /photos/:id/like

#DELETE /photos/:id/like

  #GET /categories
  def categories do
    # Possibly want a consistent api, either return streams always, or lists always.
    ResultStream.new("/categories") |> Enum.to_list
  end

#GET /categories/:id

#GET /categories/:id/photos

#GET /curated_batches

#GET /curated_batches/:id

#GET /curated_batch/:id/photos

#GET /stats/total
end
