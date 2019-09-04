defmodule TLSTest do
  use ExUnit.Case, async: true

  import Liquid.TLS.Handshake

  test "resolves handshake types" do
    assert type(:hello_request) == 0
  end

  test "converts handshake atoms to strings" do
    assert type('hello_request') == 0
  end

  test "fails on invalid type" do
    catch_error(type(:goodbye))
  end
end
