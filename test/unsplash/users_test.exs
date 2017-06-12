defmodule Unsplash.UsersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "Unsplash.Users.get(username)" do
    use_cassette "users_username" do
      response = Unsplash.Users.get("believenyaself") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Users.portfolio(username)" do
    use_cassette "users_username_portfolio" do
      response = Unsplash.Users.portfolio("believenyaself")
      assert response |> Map.get("url")
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Users.photos(username)" do
    use_cassette "users_username_photos" do
      response = Unsplash.Users.photos("believenyaself", stats: true) |> Enum.at(0)
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Users.likes(username)" do
    use_cassette "users_username_likes" do
      response = Unsplash.Users.likes("believenyaself") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Users.collections(username)" do
    use_cassette "users_username_collections" do
      response = Unsplash.Users.collections("believenyaself") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  test "Unsplash.Users.statistics(username)" do
    use_cassette "users_username_statistics" do
      response = Unsplash.Users.statistics("believenyaself") |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  @tag skip: true
  test "Unsplash.Users.me" do
    use_cassette "me" do
      response = Unsplash.Users.me |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

  @tag skip: true
  test "Unsplash.Users.update_me" do
    use_cassette "update_me" do
      response = Unsplash.Users.update_me(first_name: "Elixir", last_name: "Rocks", email: "elixir-#{Enum.take_random(?a..?z, 5)}@elixir-lang.org", url: "http://elixir-lang.org/", location: "São Paulo", bio: "Elixir is a dynamic, functional language designed for building scalable and maintainable applications.", instagram_username: "elixirlang" ) |> Enum.to_list
      assert response
      refute response |> Enum.into(%{}) |> Map.get("errors")
    end
  end

end
