defmodule Unsplash.PhotosTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import PathHelpers

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

  # Upload Photo
  test "Unsplash.upload_photo(path)" do
    use_cassette "upload_photo" do
      response = Unsplash.upload_photo(fixture_path("photo.jpg")) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  # Like / Unlike photos
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
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

end
