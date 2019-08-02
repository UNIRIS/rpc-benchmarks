defmodule BertRpcTest do
  use ExUnit.Case
  doctest BertRpc

  test "greets the world" do
    assert BertRpc.hello() == :world
  end
end
