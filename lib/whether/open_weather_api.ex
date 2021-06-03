defmodule Whether.API do
  @api_key Application.get_env(:whether, :api_key)
  @make_request Application.get_env(:whether, :http_request, &HTTPoison.get/1)

  def call_api(city, _state) do
    url = "api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&appid=#{@api_key}"

    with {:ok, %{body: body, status_code: 200}} <- @make_request.(url),
         {:ok, data} <- Jason.decode(body) do
      {:ok, map_weather(data)}
    else
      {:ok, %{status_code: 404}} -> {:error, "Invalid City, please check for typos"}
      err -> err
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
