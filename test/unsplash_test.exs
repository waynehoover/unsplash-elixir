defmodule UnsplashTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import PathHelpers

  doctest Unsplash.OAuth

  setup_all do
    ExVCR.Config.filter_sensitive_data("Client-ID.*", "Client-ID client_id")
    ExVCR.Config.filter_sensitive_data("Bearer.*", "Bearer OAuth_access_token")
    # dummy token
    Unsplash.OAuth.store_token "9fc2ea9b2884cfd93daf670f01328d7058b7485553d23370c1b6df6346e20d08"
    HTTPoison.start
  end

  # Categories
  test "Unsplash.categories" do
    use_cassette "categories" do
      response = Unsplash.categories |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.categories(id)" do
    use_cassette "categories_id" do
      response = Unsplash.categories("2") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.categories(id, :photos)" do
    use_cassette "categories_id_photos" do
      response = Unsplash.categories("2", :photos) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Photos
  test "Unsplash.photos(:all)" do
    use_cassette "photos" do
      response = Unsplash.photos(:all) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.photos(:search, opts)" do
    use_cassette "photos_search" do
      response = Unsplash.photos(:search, query: "nature") |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.photos(:search, per_page: 33)" do
    use_cassette "photos_search_33_per_page" do
      assert Enum.count(Unsplash.photos(:search, query: "nature", per_page: 30) |> Enum.take(33)) == 33
    end
  end

  test "Unsplash.photos(:random, opts)" do
    use_cassette "photos_random" do
      response = Unsplash.photos(:random, query: "nature", w: 200, h: 200, ) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.photos(id, opts)" do
    use_cassette "photos_id" do
      response = Unsplash.photos("0XR2s9D3PLI", rect: "4,4,200,200") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Stats
  test "Unsplash.stats" do
    use_cassette "stats" do
      response = Unsplash.stats |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Collections
  test "Unsplash.collections" do
    use_cassette "collections" do
      response = Unsplash.collections |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.curated_collections" do
    use_cassette "curated_collections" do
      response = Unsplash.curated_collections |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.collections(id)" do
    use_cassette "collections_id" do
      response = Unsplash.collections("175361") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.curated_collections(id)" do
    use_cassette "curated_collections_id" do
      response = Unsplash.curated_collections("103") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.collections(id, :photos)" do
    use_cassette "collections_id_photos" do
      response = Unsplash.collections("175361", :photos) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.curated_collections(id, :photos)" do
    use_cassette "curated_collections_id_photos" do
      response = Unsplash.curated_collections("103", :photos) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Upload Photo
  test "Unsplash.upload_photo(path)" do
    use_cassette "upload_photo" do
      response = Unsplash.upload_photo(fixture_path("photo.jpg")) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Like photos
  test "Unsplash.photos(id, :like)" do
    use_cassette "like_photo" do
      response = Unsplash.photos("0XR2s9D3PLI", :like) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.photos(id, :unlike)" do
    use_cassette "unlike_photo" do
      response = Unsplash.photos("0XR2s9D3PLI", :unlike)
      assert response
    end
  end

  # Users
  test "Unsplash.me" do
    use_cassette "me" do
      response = Unsplash.me |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.update_me" do
    use_cassette "update_me" do
      response = Unsplash.update_me(first_name: "Elixir", last_name: "Rocks", email: "elixir@elixir-lang.org", url: "http://elixir-lang.org/", location: "São Paulo", bio: "Elixir is a dynamic, functional language designed for building scalable and maintainable applications.", instagram_username: "elixirlang" ) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.users(username)" do
    use_cassette "users_username" do
      response = Unsplash.users("believenyaself") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.users(username, :photos)" do
    use_cassette "users_username_photos" do
      response = Unsplash.users("believenyaself", :photos) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.users(username, :likes)" do
    use_cassette "users_username_likes" do
      response = Unsplash.users("believenyaself", :likes) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

end
