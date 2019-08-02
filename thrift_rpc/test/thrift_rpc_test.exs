defmodule ThriftRpcTest do
  use ExUnit.Case
  doctest ThriftRpc

  test "greets the world" do
    assert ThriftRpc.hello() == :world
  end
end
