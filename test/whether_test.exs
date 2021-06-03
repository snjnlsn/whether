defmodule Whether.Test do
  use ExUnit.Case
  doctest Whether

  @test_data "[\n  {\n    \"name\": \"Sweater\",\n    \"waterproof\": false,\n    \"min_temp\": 50,\n    \"max_temp\": 68,\n    \"max_wind\": 40,\n    \"min_wind\": 0\n  },\n  {\n    \"name\": \"Light Coat\",\n    \"waterproof\": true,\n    \"min_temp\": 35,\n    \"max_temp\": 55,\n    \"max_wind\": 50,\n    \"min_wind\": 0\n  },\n  {\n    \"name\": \"Comfortable Shoes\",\n    \"waterproof\": false,\n    \"min_temp\": 25,\n    \"max_temp\": 90,\n    \"max_wind\": 100,\n    \"min_wind\": 0\n  }\n]\n"

  @test_data_secondary "[\n  {\n    \"name\": \"Sunglasses\",\n    \"waterproof\": false,\n    \"min_temp\": 50,\n    \"max_temp\": 80,\n    \"max_wind\": 100,\n    \"min_wind\": 0\n  }\n]\n"
  @path Application.get_env(:whether, :reccomendations_data)

  setup_all do
    File.write!(@path, @test_data)
    on_exit(fn -> File.rm!(@path) end)
  end

  test "returns response from config" do
    assert {:ok, _} = Whether.get_reccomendations("Cincinnati", "Ohio")
  end

  test "calls openAPI with location arguments" do
    assert {:ok, "Bring Sweater, Comfortable Shoes"} =
             Whether.get_reccomendations("Cincinnati", "Ohio")
  end

  test "handles api bad response argument" do
    assert {:error, "Invalid City, please check for typos"} =
             Whether.get_reccomendations("Invalid", "Invalid")
  end

  test "applies whether data against config file for reccomendations" do
    assert {:ok, "Bring Sweater, Comfortable Shoes"} =
             Whether.get_reccomendations("Cincinnati", "Ohio")

    File.write!(@path, @test_data_secondary)

    assert {:ok, "Bring Sunglasses"} = Whether.get_reccomendations("Cincinnati", "Ohio")
  end
end
