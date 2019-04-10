defmodule Unsplash.Search do
  @moduledoc ~S"""
  ## /search
  All /search/* api endpoints
  """

  alias Unsplash.Utils.ResultStream

  @doc ~S"""
  GET /search/photos

  Args:
    * `opts` - Keyword list of options
  Options:
    * `query` - Search terms.
    * `collections` - Collection ID(‘s) to narrow search. If multiple, comma-separated.
    * `orientation` - Filter search results by photo orientation. Valid values are landscape, portrait, and squarish.
  """
  def photos(opts \\ []) do
    ResultStream.new("/search/photos", opts)
  end

  @doc ~S"""
  GET /search/collections

  Args:
    * `query` Search terms.
  """
  def collections(opts \\ []) do
    ResultStream.new("/search/collections", opts)
  end

  @doc ~S"""
  GET /search/users

  Args:
    * `query` Search terms.
  """
  def users(opts \\ []) do
    ResultStream.new("/search/users", opts)
  end
end
