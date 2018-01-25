defmodule Unsplash.Stats do
  @moduledoc ~S"""
  ## /stats
  The only stat api endpoint
  """

  alias Unsplash.Utils.ResultStream

  @doc ~S"""
  GET /stats/total
  """
  def total do
    ResultStream.new("/stats/total")
  end
end
