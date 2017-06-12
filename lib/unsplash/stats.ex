defmodule Unsplash.Stats do
  alias Unsplash.Utils.ResultStream

  @doc ~S"""
  GET /stats/total
  """
  def total do
    ResultStream.new("/stats/total")
  end

end
