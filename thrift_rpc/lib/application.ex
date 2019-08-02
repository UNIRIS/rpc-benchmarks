defmodule ThriftRpc.Application do
  use Application

  def start(_, _) do
    children = [
      server_child_spec()
    ]
    Supervisor.start_link(children, [strategy: :one_for_one])
  end

  defp server_child_spec() do
    %{
      id: Thrift.Generated.Service.Binary.Framed.Server,
      start: {Thrift.Generated.Service.Binary.Framed.Server, :start_link, [ThriftRpc.ServiceHandler, 5000, [worker_count: 100]]},
      type: :supervisor
    }
  end
end
