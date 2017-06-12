defmodule Unsplash.SearchTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "Unsplash.Search.photos" do
    use_cassette "search_photos" do
      response = Unsplash.Search.photos(query: "El Capitan") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Search.collections" do
    use_cassette "search_collections" do
      response = Unsplash.Search.collections(query: "El Capitan") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Search.users" do
    use_cassette "search_users" do
      response = Unsplash.Search.users(query: "El Capitan") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end
end
