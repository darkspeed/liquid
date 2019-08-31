defmodule LiquidTest do
  use ExUnit.Case
  doctest Liquid

  test "greets the world" do
    assert Liquid.hello() == :world
  end
end
