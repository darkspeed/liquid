defmodule TLSTest do
  use ExUnit.Case, async: true

  import Liquid.Request

  describe "request parsing" do
<<<<<<< HEAD
    defp test_parse(req), do: parse(:record_layer, {:ok, [], req})

    test "parses valid record layer" do
      record_header = <<0x16, 0x03, 0x01, 0x00, 0xA5>>
=======

    defp test_parse(req), do: parse(:record_layer, {:ok, [], req})

    test "parses valid record layer" do
      record_header = <<0x16, 0x03, 0x01, 0x00, 0xa5>>
>>>>>>> Define record layer parsing function and tests
      result = test_parse(record_header)
      assert result == {:ok, [record_layer: [version: {3, 1}, length: 165]], <<>>}
    end

    test "fails on incorrect TLS version" do
<<<<<<< HEAD
      bad_version = <<0x16, 0xFF, 0xFF, 0x00, 0xA5>>
      result = test_parse(bad_version)
      refute match?({:ok, _, _}, result)
    end

    test "fails on malformed request" do
      bad_request = <<0, 0, 4, 4, 1>>
      result = test_parse(bad_request)
      refute match?({:ok, _, _}, result)
    end

    test "passes unparsed input through" do
      request = <<0x16, 0x03, 0x01, 0x00, 0xA5, 0xFF, 0xFF>>
      {_, _, remaining} = test_parse(request)
      assert remaining == <<0xFF, 0xFF>>
=======
      bad_version = <<0x16, 0xFF, 0xFF, 0x00, 0xa5>>
      result = test_parse bad_version
      refute match?({:ok, _, _}, result)
    end

    test "fails on malformed request" do
      bad_request = <<0, 0, 4, 4, 1>>
      result = test_parse bad_request
      refute match?({:ok, _, _}, result)
>>>>>>> Define record layer parsing function and tests
    end

    test "client hello handshake header" do
      handshake_header = <<1, 0, 0, 0xA1>>
      result = Liquid.Request.ClientHello.parse(:handshake_header, {:ok, [], handshake_header})
      assert result == {:ok, [handshake_type: 1, length: 161], ""}
    end
  end
end
