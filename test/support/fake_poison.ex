defmodule Whether.Test.FakePoison do
  @valid_body "{\"coord\":{\"lon\":-84.4569,\"lat\":39.162},\"weather\":[{\"id\":804,\"main\":\"Clouds\",\"description\":\"overcast clouds\",\"icon\":\"04n\"}],\"base\":\"stations\",\"main\":{\"temp\":64.63,\"feels_like\":65.35,\"temp_min\":63.05,\"temp_max\":66,\"pressure\":1008,\"humidity\":97},\"visibility\":10000,\"wind\":{\"speed\":5.75,\"deg\":200},\"clouds\":{\"all\":90},\"dt\":1622688279,\"sys\":{\"type\":2,\"id\":2040238,\"country\":\"US\",\"sunrise\":1622628797,\"sunset\":1622681928},\"timezone\":-14400,\"id\":4508722,\"name\":\"Cincinnati\",\"cod\":200}"

  def get(url) do
    cond do
      String.match?(url, ~r/\binvalid\b/) -> {:ok, %{status_code: 404}}
      String.match?(url, ~r/\bcincinnati\b/) -> {:ok, %{body: @valid_body, status_code: 200}}
    end
  end
end
