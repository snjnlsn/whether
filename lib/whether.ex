defmodule Whether do
  alias Whether.{Items, API}

  @moduledoc """
  Documentation for `Whether`.
  """

  @doc """
    Is called by escript - values for city and state args are passed into logic functions
  """
  def main(argv \\ []) do
    {args, _} = OptionParser.parse!(argv, strict: [state: :string, city: :string])
    Whether.get_reccomendations(args[:city], args[:state])
  end

  @doc """
    Returns reccomendations based off city / state passed
  """
  def get_reccomendations(city, state) do
    with {:ok, resp} <- API.call_api(city, state),
         {:ok, string} = Items.get_pertinent_items(resp) do
      IO.puts(string)
    else
      err -> IO.inspect(err, label: "err")
    end
  end
end
