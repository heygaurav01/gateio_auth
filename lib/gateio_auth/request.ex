defmodule GateioAuth.Request do
  @moduledoc """
  Makes authenticated requests to Gate.io API.
  """
  alias GateioAuth.{Auth, GateioSpotAccount} # Alias for GateioSpotAccount
  require Logger

  @host "https://api.gateio.ws"
  @prefix "/api/v4"

  @doc """
  Fetches the total wallet balance.
  """
  def fetch_wallet_total_balance do
    url = "#{@prefix}/wallet/total_balance"
    full_url = "#{@host}#{url}"

    # Generate headers
    headers = Auth.generate_signature("GET", url)

    # Make the request
    case HTTPoison.get(full_url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with data <- Jason.decode!(body) do
          details = Map.get(data, "details")
          total = Map.get(data, "total")
          total_map = %{
            "total_amount" => total["amount"],
            "total_borrowed" => total["borrowed"],
            "total_currency" => total["currency"],
            "total_unrealised_pnl" => total["unrealised_pnl"]
          }
          detail = Map.merge(details, total_map)
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

  @doc """
  Fetches the spot accounts data.
  """
  def fetch_spot_accounts do
    endpoint = "/spot/accounts"
    url = "#{@prefix}#{endpoint}"
    full_url = "#{@host}#{url}"

    # Generate headers
    headers = Auth.generate_signature("GET", url)

    # Make the request
    case HTTPoison.get(full_url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with data <- Jason.decode!(body) |> dbg do
          Logger.info("Spot accounts fetched successfully: #{inspect(data)}")

          # Now `data` is a list, directly process it
          Enum.each(data, fn account ->
            # Create a struct with the map data
            account_data = %GateioSpotAccount{
              currency: account["currency"],
              available: Decimal.new(account["available"]),
              locked: Decimal.new(account["locked"]),
              update_id: account["update_id"]
            }

            # Insert the spot account into the database
            case GateioAuth.Repo.insert(account_data) do
              {:ok, _record} ->
                Logger.info("Spot account inserted successfully.")
              {:error, reason} ->
                Logger.error("Failed to insert spot account: #{inspect(reason)}")
            end
          end)

          {:ok, data}
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
