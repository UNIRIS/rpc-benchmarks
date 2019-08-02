defmodule RanchAvro do
  use Application

  def start(_, _) do
    children = [
      {RanchAvro.Server, [port: 10000]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: RanchAvro.Supervisor)
  end
end
