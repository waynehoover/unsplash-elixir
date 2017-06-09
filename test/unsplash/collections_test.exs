defmodule Unsplash.CollectionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

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

end
