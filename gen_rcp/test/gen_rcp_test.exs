defmodule GenRcpTest do
  use ExUnit.Case
  doctest GenRcp

  test "greets the world" do
    assert GenRcp.hello() == :world
  end
end
