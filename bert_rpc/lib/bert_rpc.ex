defmodule BertRpc do
  use Application

  def start(_,_) do

    children = [
      {BertRpc.Server, [port: 9000]}
    ]

    Supervisor.start_link(children, [strategy: :one_for_one])
  end

end
