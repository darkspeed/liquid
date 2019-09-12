defmodule Liquid.Requests do
  import Liquid.Request

  defmodule ClientHello do
    @moduledoc """
    The Handshake protocol client hello message.
    """
    use Liquid.Request

    @handshake 1

    @impl Liquid.Request
    def fields,
      do: [
        :handshake_header,
        :client_version,
        :client_random,
        :session_id,
        :cipher_suites,
        :compression_methods,
        :extensions
      ]

    field :handshake_header, stream do
      <<@handshake, length::size(24), remaining::binary>> = stream
      {:ok, [handshake_type: @handshake, length: length], remaining}
    end

    field :client_version, stream do
    end
  end
end
