defmodule Whether.Items do
  use Ecto.Schema
  require IEx
  import Ecto.Changeset

  schema "item" do
    field(:name, :string)
    field(:waterproof, :boolean)
    field(:min_temp, :integer)
    field(:max_temp, :integer)
    field(:max_wind, :integer)
    field(:min_wind, :integer)
  end

  def get_pertinent_items(weather) do
    IEx.pry()

    with {:ok, raw} <- File.read("config/items.json"),
         {:ok, json} <- Jason.decode(raw) do
      items =
        json
        |> Enum.map(fn sug ->
          changeset(%__MODULE__{}, sug, weather)
        end)
        |> Enum.filter(fn item -> item.valid? end)

      {:ok, items}
    else
      err -> err
    end
  end

  def changeset(struct, params, weather) do
    struct
    |> cast(params, [
      :name,
      :waterproof,
      :min_temp,
      :max_temp,
      :max_wind,
      :min_wind
    ])
    |> validate_required([:name])
    |> validate_temperature(weather)
    |> validate_wind(weather)
    |> validate_waterproof(weather)
  end

  defp validate_temperature(changeset, weather) do
    IEx.pry()
    min = get_field(changeset, :min_temp)
    max = get_field(changeset, :max_temp)

    cond do
      min > weather[:temp] -> add_error(changeset, :min_temp, "item requires warmer weather")
      max < weather[:temp] -> add_error(changeset, :max_temp, "item requires colder weather")
      true -> changeset
    end
  end

  defp validate_wind(changeset, weather) do
    min = get_field(changeset, :min_wind)
    max = get_field(changeset, :max_wind)

    cond do
      min > weather[:wind] -> add_error(changeset, :min_wind, "item requires windier weather")
      max < weather[:wind] -> add_error(changeset, :max_wind, "item requires less windy weather")
      true -> changeset
    end
  end

  defp validate_waterproof(changeset, weather) do
    waterproof = get_field(changeset, :waterproof)

    cond do
      waterproof && weather[:main] !== "Rain" ->
        add_error(changeset, :waterproof, "item requires rainier weather")

      !waterproof && weather[:main] === "Rain" ->
        add_error(changeset, :waterproof, "item cannot handle current rainy weather")

      true ->
        changeset
    end
  end
end
