defmodule Unsplash.Stats do
  @moduledoc ~S"""
  All /stats/* api endpoints
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
