defmodule Unsplash.CategoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

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
end
