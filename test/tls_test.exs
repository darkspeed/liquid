defmodule TLSTest do
  use ExUnit.Case, async: true

  import Liquid.TLS.Request

  describe "request parsing" do

    defp test_parse(req), do: parse(:record_layer, {:ok, [], req})

    test "parses valid record layer" do
      record_header = <<0x16, 0x03, 0x01, 0x00, 0xa5>>
      result = test_parse(record_header)
      assert result == {:ok, [record_layer: [version: {3, 1}, length: 165]], <<>>}
    end

    test "fails on incorrect TLS version" do
      bad_version = <<0x16, 0xFF, 0xFF, 0x00, 0xa5>>
      result = test_parse bad_version
      refute match?({:ok, _, _}, result)
    end

    test "fails on malformed request" do
      bad_request = <<0, 0, 4, 4, 1>>
      result = test_parse bad_request
      refute match?({:ok, _, _}, result)
    end
  end
end
