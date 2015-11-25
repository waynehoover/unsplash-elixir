defmodule UnsplashTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  # doctest Unsplash.OAuth

  setup_all do
    ExVCR.Config.filter_sensitive_data("Client-ID.*", "Client-ID client_id")
    ExVCR.Config.filter_sensitive_data("Bearer.*", "Bearer OAuth_access_token")
    HTTPoison.start
  end

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

end
