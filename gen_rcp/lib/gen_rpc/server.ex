defmodule GenRpc.Server do

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, [name: __MODULE__])
  end

  def init(_) do
    :application.set_env(:gen_rpc, :rpc_module_list, [GenRpc.Transaction])
    :application.set_env(:gen_rpc, :rpc_module_control, :whitelist)
    {:ok, []}
  end
end
