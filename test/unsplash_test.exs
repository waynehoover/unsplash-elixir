defmodule UnsplashTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Unsplash.OAuth

  setup_all do
    ExVCR.Config.filter_sensitive_data("Client-ID.*", "Client-ID client_id")
    ExVCR.Config.filter_sensitive_data("Bearer.*", "Bearer OAuth_access_token")
    HTTPoison.start
  end

  # Categories
  test "Unsplash.categories" do
    use_cassette "categories" do
      assert is_list (Unsplash.categories |> Enum.to_list)
    end
  end

  test "Unsplash.categories(id)" do
    use_cassette "categories_id" do
      assert is_list (Unsplash.categories("2") |> Enum.to_list)
    end
  end

  test "Unsplash.categories(id, :photos)" do
    use_cassette "categories_id_photos" do
      assert is_list (Unsplash.categories("2", :photos) |> Enum.take(1))
    end
  end

  # Photos
  test "Unsplash.photos" do
    use_cassette "photos" do
      assert is_list Unsplash.photos |> Enum.take(1)
    end
  end

  test "Unsplash.photos(:search, opts)" do
    use_cassette "photos_search" do
      assert is_list Unsplash.photos(:search, query: "Austin", catgeroy: "2") |> Enum.take(1)
    end
  end

  test "Unsplash.photos(:random, opts)" do
    use_cassette "photos_random" do
      assert is_list Unsplash.photos(:random, query: "Austin", catgeroy: "2", w: 200, h: 200, ) |> Enum.take(1)
    end
  end

  test "Unsplash.photos(id, opts)" do
    use_cassette "photos_id" do
      assert is_list Unsplash.photos("0XR2s9D3PLI", rect: "4,4,200,200") |> Enum.to_list
    end
  end

  # Stats
  test "Unsplash.stats" do
    use_cassette "stats" do
      assert is_list Unsplash.stats |> Enum.to_list
    end
  end

end
