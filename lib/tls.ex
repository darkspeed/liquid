defmodule Liquid.TLS do
  @moduledoc """
  Liquid's implementation of the TLS 1.2 Handshake Protocol.
  See [the specification](https://tools.ietf.org/html/rfc5246#section-1.2)
  for more information.
  """

  defmodule Request do
    @callback type() :: {atom(), byte()}
    @callback fields() :: [atom()]

    @doc false
    defmacro __using__(_opts) do
      quote do
        import Request

        @behaviour Request
        defoverridable Request
      end
    end

    @doc """
    Constructs a request field function (RFF).
    """
    defmacro field(name, do: body) do
      quote do
        body = unquote(body)
        defp(field(unquote(:"#{name}")), do: unquote(body))
      end
    end

    def parse(type) do
    end
  end

  defmodule TestReq do
    use Liquid.TLS.Request

    field :test do
      1 + 1
    end

  end
end
