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
  def fetch_wallet_total_balance() do
    url = "#{@prefix}/wallet/total_balance"
    full_url = "#{@host}#{url}"
    # Generate headers
    headers = Auth.generate_signature("GET", url)


    # Make the request
    case HTTPoison.get(full_url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
      with data <- Jason.decode!(body) do
        dbg(data)
        details = Map.get(data, "details")
        total = Map.get(data,"total")
        total_map = %{"total_amount" => total["amount"],
        "total_borrowed"=> total["borrowed"],
        "total_currency"=> total["currency"],
        "total_unrealised_pnl"=> total["unrealised_pnl"],
      }
        detail = Map.merge(details , total_map)
        GateioAuth.Gateio.insert_wallet_balance(detail)
      end

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        Logger.error("Request failed: #{status} - #{body}")
        {:error, body}

      {:error, reason} ->
        Logger.error("HTTP error: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
