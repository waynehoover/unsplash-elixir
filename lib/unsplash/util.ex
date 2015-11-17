defmodule Unsplash.Util do
  @doc """
  Returns a keyword list of only those keys given as first argument. Second argument is a keyword list to extract values from.

  ## Examples

      iex> Unsplash.Util.parse_options([:w, :h], [w: 200, z: 300])
      [w: 200]
      iex> Unsplash.Util.parse_options([:w, :h], [w: 200, h: 300])
      [w: 200, h: 300]
      iex> Unsplash.Util.parse_options([:z], [w: 200, h: 300])
      []

  """
  def parse_options(params, options) do
    params
    |> Enum.filter_map(
      fn (param) -> options[param] end,
      fn (param) ->
        {param, options[param]}
      end
    )
  end
end
