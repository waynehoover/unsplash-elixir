defmodule Unsplash.Stats do
  @moduledoc ~S"""
  ## /stats
  """

  alias Unsplash.Utils.ResultStream

  @doc ~S"""
  GET /stats/total
  """
  def total do
    ResultStream.new("/stats/total")
  end

  @doc ~S"""
  GET /stats/month
  """
  def month do
    ResultStream.new("/stats/total")
  end
end
