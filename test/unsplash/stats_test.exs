defmodule Unsplash.StatsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "Unsplash.Stats.total" do
    use_cassette "stats_total" do
      response = Unsplash.Stats.total() |> Enum.to_list()
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Stats.month" do
    use_cassette "stats_month" do
      response = Unsplash.Stats.month() |> Enum.to_list()
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end
end
