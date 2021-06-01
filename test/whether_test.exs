defmodule WhetherTest do
  use ExUnit.Case
  doctest Whether

  test "returns response from config" do
    assert {:ok, _} = Whether.get_reccomendation("Cincinnati", "Ohio")
  end

  @tag :skip
  test "calls openAPI with location arguments" do
    # stub api to respond with correct thing here
    assert {:ok, "wear a hat!"} = Whether.get_reccomendation("Cincinnati", "Ohio")
  end

  @tag :skip
  test "handles api bad response argument" do
    # stub api to respond with bad response
    assert {:error, _} = Whether.get_reccomendation("badplace", "not a state")
  end

  @tag :skip
  test "applies whether data against config file for reccomendations" do
    # stub api to respond with whatever for austin range

    assert {:ok, "sunny!"} = Whether.get_reccomendation("Austin", "Texas")

    # write to FS json config map

    assert {:ok, "not sunny!"} = Whether.get_reccomendation("Austin", "Texas")
  end
end
