defmodule RanchRpc.Server do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(port: port) do
    :ranch.start_listener(:erlang_rpc, 1000, :ranch_tcp, [{:port, port}], RanchRpc.Handler, [{:backlog, 1000}])
  end
end
