defmodule Unsplash do
  @moduledoc ~S"""
  # The Unslpash API in Elixir

  ## Pagination
  Those API results that are paginated will return a Stream in which you can resolve by using any Enum function. You can also pass in `per_page` and `page` keywords if you would like to do pagination manually. Max per_page is 30.
  """
  def start(_type, _args) do
    Unsplash.Utils.OAuth.start
  end
end
