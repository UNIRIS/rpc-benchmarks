defmodule ThriftRpc.ServiceHandler do
  @behaviour Thrift.Generated.Service.Handler

  @impl true
  def send_transaction(tx) do
    tx
  end
end
