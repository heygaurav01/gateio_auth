defmodule GateioAuth.Request do
  @moduledoc """
  Makes authenticated requests to Gate.io API.
  """
  alias GateioAuth.{Auth, GateioSpotAccount, SpotOrder, Repo}
  require Logger
  alias Ecto.Multi

  @host "https://api.gateio.ws"
  @prefix "/api/v4"

  @doc """
  Fetches the total wallet balance.
  """
  def fetch_wallet_total_balance do
    url = "#{@prefix}/wallet/total_balance"
    full_url = "#{@host}#{url}"

    headers = Auth.generate_signature("GET", url)

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

    headers = Auth.generate_signature("GET", url)

    case HTTPoison.get(full_url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with data <- Jason.decode!(body) do
          Logger.info("Spot accounts fetched successfully: #{inspect(data)}")

          multi = Enum.reduce(data, Multi.new(), fn account, multi ->
            changeset = GateioSpotAccount.changeset(%GateioSpotAccount{}, %{
              currency: account["currency"],
              available: Decimal.new(account["available"] || "0"),
              locked: Decimal.new(account["locked"] || "0"),
              update_id: account["update_id"]
            })


          Multi.insert(multi, account["currency"], changeset, on_conflict: :nothing)
        end)

        with {:ok, inserted_data}<- Repo.transaction(multi) do
          Logger.info("Spot accounts inserted successfully.")
         Enum.reduce(inserted_data, [], fn {_key, value}, res ->
                [value | res]
            end)
          end

          {:ok, data}
        end

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        Logger.error("API Request failed: #{status} - #{body}")
        {:error, body}

      {:error, reason} ->
        Logger.error("HTTP error: #{inspect(reason)}")
        {:error, reason}
    end
  end

  @doc """
  Fetches the spot orders and stores them in the database.
  """
  def fetch_spot_orders do
    endpoint = "/spot/my_trades"
    query_param = ""
    url = "#{@prefix}#{endpoint}"
    full_url = "#{@host}#{url}?#{query_param}"

    headers = Auth.generate_signature("GET", url, query_param)

    case HTTPoison.get(full_url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        orders = Jason.decode!(body)



        multi = Enum.reduce(orders, Multi.new(), fn order, multi ->
          changeset = SpotOrder.changeset(%SpotOrder{}, %{
            amend_text: order["amend_text"],
            amount: Decimal.new(order["amount"] || "0"),
            create_time: safe_to_integer(order["create_time"]),
            create_time_ms: Decimal.new(order["create_time_ms"] || "0"),
            currency_pair: order["currency_pair"],
            fee: Decimal.new(order["fee"] || "0"),
            fee_currency: order["fee_currency"],
            gt_fee: Decimal.new(order["gt_fee"] || "0"),
            trx_id: order["id"],
            order_id: order["order_id"],
            point_fee: Decimal.new(order["point_fee"] || "0"),
            price: Decimal.new(order["price"] || "0"),
            filled_amount: Decimal.new(order["filled_amount"] || "0"),
            fill_price: Decimal.new(order["fill_price"] || "0"),
            role: order["role"],
            sequence_id: safe_to_integer(order["sequence_id"]),
            side: order["side"],
            text: order["text"]
          })

          Multi.insert(multi, order["id"], changeset, on_conflict: :nothing)
        end)

       with {:ok, inserted_data}<- Repo.transaction(multi) do
        Logger.info("Spot orders inserted successfully.")
       Enum.reduce(inserted_data, [], fn {_key, value}, res ->
              [value | res]
          end)


        end

        {:ok, orders}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        Logger.error("API request failed: #{status} - #{body}")
        {:error, body}

      {:error, reason} ->
        Logger.error("HTTP error: #{inspect(reason)}")
        {:error, reason}
    end
  end
  defp safe_to_integer(nil), do: 0
  defp safe_to_integer(value) when is_binary(value), do: String.to_integer(value)
  defp safe_to_integer(_), do: 0

end
