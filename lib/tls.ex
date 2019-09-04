defmodule Liquid.TLS.Handshake do
  @moduledoc """
  Liquid's implementation of the TLS 1.2 Handshake Protocol.
  See [the specification](https://tools.ietf.org/html/rfc5246#section-1.2)
  for more information.
  """

  @doc """
  Maps the given handshake type, as an atom or a string, to it's corresponding numerical value 
  by [§7.4. Handshake Protocol](https://tools.ietf.org/html/rfc5246#section-7.4).
  """
  def type(handshake) when is_atom(handshake) do
    case handshake do
      :hello_request -> 0x0
      :client_hello -> 0x1
      :server_hello -> 0x2
      :certificate -> 0xB
      :server_key_exchange -> 0xC
      :certificate_request -> 0xD
      :server_hello_done -> 0xE
      :certificate_verify -> 0xF
      :client_key_exchange -> 0x10
      :finished -> 0x14
    end
  end

  def type(handshake), do: type(List.to_atom(handshake))
end
