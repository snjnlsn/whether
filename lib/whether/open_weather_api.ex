defmodule Whether.API do
  require IEx

  @api_key Application.fetch_env!(:whether, :api_key)

  def call_api(city, _state) do
    url = "api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&appid=#{@api_key}"

    with {:ok, %{body: body}} <- HTTPoison.get(url),
         {:ok, data} <- Jason.decode(body) do
      map_weather(data)
    end
  end

  defp map_weather(data) do
    Enum.reduce(data, %{}, fn {name, val}, acc ->
      cond do
        name === "main" ->
          Map.put(acc, :temp, val["temp"])

        name === "weather" ->
          Map.put(acc, :main, List.first(val)["main"])

        name === "wind" ->
          Map.put(acc, :wind, val["speed"])

        true ->
          acc
      end
    end)
  end
end
