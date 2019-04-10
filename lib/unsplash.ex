defmodule Unsplash do
  @moduledoc ~S"""
  # The Unslpash API in Elixir

  ## Pagination
  The API results that are paginated return a Stream which can be resolve by using any Enum function.
  Or in other words, you don't need ot think about pagination.
  But if you would like to think about pagination can also pass in `per_page` and `page` keywords. The max `per_page` is 30.
  """
  def start(_type, _args) do
    Unsplash.Utils.OAuth.start()
  end
end
