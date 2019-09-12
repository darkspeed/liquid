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
      <<major, minor, request::binary>> = stream
      {:ok, [version: {major, minor}], request}
    end

    field :client_random, stream do
      <<random :: size(256), request :: binary>> = stream
      {:ok, [random: random], request}
    end

    field :session_id, stream do
      <<id, request :: binary>> = stream
      {:ok, [id: id], request}
    end
  end
end
