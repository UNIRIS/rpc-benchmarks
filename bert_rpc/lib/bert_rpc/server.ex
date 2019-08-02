defmodule BertRpc.Server do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, [name: __MODULE__])
  end

  def init([port: port]) do
    BertGate.Server.start_link(%{
      port: port,
      public: [:'Bert',:'Transaction'],
      acceptors_num: 100
    })
  end
end
