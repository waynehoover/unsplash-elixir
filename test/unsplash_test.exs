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

  # Curated Batches
  test "Unsplash.curated_batches" do
    use_cassette "curated_batches" do
      assert is_list Unsplash.curated_batches |> Enum.take(1)
    end
  end

  test "Unsplash.curated_batches(id)" do
    use_cassette "curated_batches_id" do
      assert is_list Unsplash.curated_batches("90") |> Enum.take(1)
    end
  end

  test "Unsplash.curated_batches(id, :photos)" do
    use_cassette "curated_batches_id_photos" do
      assert is_list Unsplash.curated_batches("90", :photos) |> Enum.take(1)
    end
  end

  # Upload Photo
  @tag :skip
  test "Unsplash.upload_photo(path)" do
    use_cassette "upload_photo" do
      assert is_list Unsplash.uplod_photo("photo.jpg") |> Enum.take(1)
    end
  end

  # Like photos
  @tag :skip
  test "Unsplash.photos(id, :like)" do
    use_cassette "like_photo" do
      assert is_list Unsplash.photos("0XR2s9D3PLI", :like) |> Enum.take(1)
    end
  end

  @tag :skip
  test "Unsplash.photos(id, :unlike)" do
    use_cassette "unlike_photo" do
      assert is_list Unsplash.photos("0XR2s9D3PLI", :unlike) |> Enum.take(1)
    end
  end

  # Users
  @tag :skip
  test "Unsplash.me" do
    use_cassette "me" do
      assert is_list Unsplash.me |> Enum.to_list
    end
  end

  @tag :skip
  test "Unsplash.update_me" do
    use_cassette "update_me" do
      assert is_list Unsplash.update_me(first_name: "Elixir", last_name: "Rocks", email: "elixir@elixir-lang.org", url: "http://elixir-lang.org/", location: "São Paulo", bio: "Elixir is a dynamic, functional language designed for building scalable and maintainable applications.", instagram_username: "elixirlang" ) |> Enum.to_list
    end
  end


  @tag :skip
  test "Unsplash.users(username)" do
    use_cassette "users_username" do
      assert is_list Unsplash.users("believenyaself") |> Enum.to_list
    end
  end

  @tag :skip
  test "Unsplash.users(username, :photos)" do
    use_cassette "users_username_photos" do
      assert is_list Unsplash.users("believenyaself", :photos) |> Enum.to_list
    end
  end

  @tag :skip
  test "Unsplash.users(username, :likes)" do
    use_cassette "users_username_likes" do
      assert is_list Unsplash.users("believenyaself", :likes) |> Enum.to_list
    end
  end

end
