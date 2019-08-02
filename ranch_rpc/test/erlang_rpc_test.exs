defmodule ErlangRpcTest do
  use ExUnit.Case
  doctest ErlangRpc

  test "greets the world" do
    assert ErlangRpc.hello() == :world
  end
end
