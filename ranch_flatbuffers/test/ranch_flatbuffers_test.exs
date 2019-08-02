defmodule RanchFlatbuffersTest do
  use ExUnit.Case
  doctest RanchFlatbuffers

  test "greets the world" do
    assert RanchFlatbuffers.hello() == :world
  end
end
