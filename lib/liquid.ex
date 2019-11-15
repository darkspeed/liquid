defmodule Liquid do
  @moduledoc """
  Pluggable proxy obfuscation designed to counteract deep packet 
  inspection and advanced fingerprinting techniques.
  """

  use Application
  require Logger

  def start(_type, opts) do
    Logger.debug("Starting Liquid supervisor...")
    {mode, opts} = Keyword.pop(opts, :mode, :client)
    case mode do
      :client -> Logger.debug("Liquid Client mode")
      _ -> raise ArgumentError, "Liquid must start in client or server mode."
    end
  end
end
