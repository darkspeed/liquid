defmodule Liquid do
  @moduledoc """
  Pluggable proxy obfuscation designed to counteract deep packet 
  inspection and advanced fingerprinting techniques.
  """

  use Application
  require Logger

  def start(_type, opts) do
    children = []

    {mode, opts} = Keyword.pop(opts, :mode, :info)

    Supervisor.start_link(children, [strategy: :one_for_one])
  end
end
