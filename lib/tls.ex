defmodule Liquid.TLS do
  @moduledoc """
  Liquid's implementation of the TLS 1.2 Handshake Protocol.
  See [the specification](https://tools.ietf.org/html/rfc5246#section-1.2)
  for more information.
  """

  defmodule Request do
    @doc false
    defmacro __using__(_opts) do
      quote do
        import Request

        @behaviour Request
        defoverridable Request
      end
    end

    @callback type() :: {atom(), byte()}
    @callback fields() :: [atom()]

    @typedoc """
    Represents a request parser. For parser combinators, this type more closely
    represents a 'parse result' rather than a 'parser object' that may be found
    in object-oriented libraries.
    """
    @type parser() :: {atom(), Keyword.t(), [byte()]}

    @doc """
    Constructs a parser combinator function for the given field name. `field` will generate
    the appropriate `parse/2` function signature using the given `do` block as an implementation.

    Within the `do` block implementation, the remaining input stream is accesible via the arguemnt
    `stream` by default. If you would like to change thhe name of the argument, do so by passing in
    an atom for `argument`.

    ## Example

      field :one_byte do
        # Consume one byte of input.
      end

    """
    defmacro field(name, argument \\ :stream, do: body) do
      quote do
        body = unquote(body)
        def parse(unquote(:"#{name}"), {:ok, _, unquote(to_string(argument))} = parse), do: unquote(body)
      end
    end

    def parse(:record_layer, {:ok, _value, stream}) do
      {header, request} = :lists.split(4, stream)
    end

    @spec parse(term, Keyword.t, String.t) :: parser()
    def parse(type, opts \\ [], string) do
      dispatch = fn field, parser ->
        case parser do
          {:ok, current, _} ->
            {status, parse, stream} = type.parse(field, parser)
            {status, Keyword.merge(current, parse), stream}

          {:error, _, _} ->
            parser
        end
      end

      parse(:record_layer, {:ok, [], string})
      |> (&Enum.reduce(type.fields(), &1, dispatch)).()
    end

    def error(field, description),
      do: {:error, [], "Error parsing field '#{field}': #{description}"}

  end
end
