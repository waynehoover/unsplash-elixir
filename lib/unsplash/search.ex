defmodule Unsplash.Search do
  alias Unsplash.Utils.ResultStream

  @doc ~S"""
  GET /search/photos

  Args:
    query Search terms.

  Options:
    page  Page number to retrieve. (Optional; default: 1)
    per_page  Number of items per page. (Optional; default: 10)
    collections Collection ID(‘s) to narrow search. If multiple, comma-separated.
  """
  def photos(opts \\ []) do
    params = [:query, :page, :per_page, :collections]
    ResultStream.new("/search/photos", params, opts)
  end

  @doc ~S"""
  GET /search/collections

  Args:
    query Search terms.

  Options:
    page  Page number to retrieve. (Optional; default: 1)
    per_page  Number of items per page. (Optional; default: 10)
  """
  def collections(opts \\ []) do
    params = [:query, :page, :per_page]
    ResultStream.new("/search/collections", params, opts)
  end

  @doc ~S"""
  GET /search/users

  Args:
    query Search terms.

  Options:
    page  Page number to retrieve. (Optional; default: 1)
    per_page  Number of items per page. (Optional; default: 10)
  """
  def users(opts \\ []) do
    params = [:query, :page, :per_page]
    ResultStream.new("/search/users", params, opts)
  end

end
