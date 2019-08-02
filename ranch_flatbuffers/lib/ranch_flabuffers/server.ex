defmodule RanchFlatbuffers.Server do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(port: port) do
    IO.puts "ok"
    :ranch.start_listener(:erlang_rpc, 100, :ranch_tcp, [{:port, port}], RanchFlatbuffers.Handler, [])
  end
end
