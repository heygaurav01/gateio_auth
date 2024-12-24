defmodule GateioAuth do
  alias GateioAuth.Request

  def fetch_order_book(market) do
    Request.fetch_order_book(market)
  end
  @moduledoc """
  GateioAuth keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
end
