defmodule Whether do
  alias Whether.{Items, API}

  @moduledoc """
  Documentation for `Whether`.
  """

  @doc """
    Returns reccomendations
  """
  @spec get_reccomendations(any, any) ::
          list
          | {:error,
             %{
               :__exception__ => true,
               :__struct__ => HTTPoison.Error | Jason.DecodeError,
               optional(:data) => binary,
               optional(:id) => nil,
               optional(:position) => integer,
               optional(:reason) => any,
               optional(:token) => any
             }}
          | {:ok,
             %{
               :__struct__ => HTTPoison.AsyncResponse | HTTPoison.Response,
               optional(:headers) => list,
               optional(:id) => reference,
               optional(:request) => HTTPoison.Request.t(),
               optional(:request_url) => any,
               optional(:status_code) => integer
             }}
  def get_reccomendations(city, state \\ "ohio") do
    with {:ok, resp} <- API.call_api(city, state),
         {:ok, items} <- Items.get_pertinent_items(resp) do
      items
    else
      err -> err
    end
  end
end
