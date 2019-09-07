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

    @type request_parser() :: {atom(), Keyword.t(), String.t()}

    @doc """
    Constructs a request field function (RFF). Given the field name, `field` will generate
    the appropriate `parse/2` function signature.

    RFFs are "modular" functions responsible for parsing a particular field within a TLS request.
    RFFs must implement the signature:

    ```parse(atom(), request_parser()) :: request_parser()```

    Where `request_parser()` is a 3-tuple containing an :ok/:error atom, the current parsed request,
    and the remaining string to be parsed.

    The implementor's `parse/1` method then dispatches, in order, the `parse/2` for every request name
    defined in the implementor's `fields/0` function to build the request.
    """
    defmacro field(name, do: body) do
      quote do
        body = unquote(body)
        def parse(unquote(:"#{name}"), {:ok, _value, stream} = parse), do: unquote(body)
      end
    end

    defp error(field, description), do: {:error, [], "Error parsing field '#{field}': #{description}"}

    # TODO: Pattern matching order? Might run into issues with the 'undefined' field. Test to determine behavior.
    defp parse(_name, {:error, _, _ } = error), do: error

    # TODO: Decide on how to name these so defmacro, defp, and def don't collide.
    def pub_parse(type, string) do
      Enum.reduce type.fields(), {:ok, [], string}, fn field, parser ->
        case parser do
          {:ok, current, _} ->
            {status, parse, stream} = type.parse(field, parser)
            {status, Keyword.merge(current, parse), stream}
          {:error, _, _} -> parser
        end
      end
    end
  end
end
