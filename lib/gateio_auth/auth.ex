defmodule GateioAuth.Auth do
  @moduledoc """
  Handles API authentication for Gate.io.
  """

  @api_key "48134462a92303af187a2744aef6f4b9"
  @api_secret "1a6b4c9e5547fd4dec2866558be5fa5290d6699b03aed426346b8efb9b8d5149"

  @doc """
  Generates the required signature headers for authentication.
  """
  def generate_signature(method, url, query_string \\ "", payload \\ "") do
    timestamp = DateTime.utc_now |> DateTime.to_unix
    hashed_payload = :crypto.hash(:sha512, git checkout -b main) |> Base.encode16(case: :lower)

    # Create the string to sign
    string_to_sign = "#{method}\n#{url}\n#{query_string}\n#{hashed_payload}\n#{timestamp}" |>dbg

    # Generate HMAC signature
    signature =
      :crypto.mac(:hmac, :sha512, @api_secret, string_to_sign)
      |> Base.encode16(case: :lower)


      # Set headers

    %{
      "Accept"=> "application/json",
      "Content-Type"=> "application/json",
      "KEY" => @api_key,
      "Timestamp" => "#{timestamp}",
      "SIGN" => signature
    }
  end
end
