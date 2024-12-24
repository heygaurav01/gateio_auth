defmodule GateioAuth.Request do
  @moduledoc """
  Makes authenticated requests to Gate.io API.
  """
  alias GateioAuth.Auth
  require Logger

  @host "https://api.gateio.ws"
  @prefix "/api/v4"

  @doc """
  Fetches the order book for a given market.
  """
  def fetch_order_book() do
    url = "#{@prefix}/wallet/total_balance"
    full_url = "#{@host}#{url}"
    # Generate headers
    headers = Auth.generate_signature("GET", url)

    dbg(headers)

    # Make the request
    case HTTPoison.get(full_url, headers, []) |> dbg do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        Logger.error("Request failed: #{status} - #{body}")
        {:error, body}

      {:error, reason} ->
        Logger.error("HTTP error: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
