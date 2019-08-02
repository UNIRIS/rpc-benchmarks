defmodule RanchAvro.Server do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(port: port) do
    :ranch.start_listener(:erlang_rpc, 100, :ranch_tcp, [{:port, port}], RanchAvro.Handler, [])
  end
end
