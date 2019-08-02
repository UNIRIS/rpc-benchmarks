defmodule RanchRpc do
  use Application

  def start(_, _) do
    children = [
      {RanchRpc.Server, [port: 6000]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: RanchRpc.Supervisor)
  end
end
