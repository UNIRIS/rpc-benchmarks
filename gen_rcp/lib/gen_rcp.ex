defmodule GenRpc do

  use Application

  def start(_,_) do
    children = [
      GenRpc.Server
    ]

    Supervisor.start_link(children, [strategy: :one_for_one])
  end

end
