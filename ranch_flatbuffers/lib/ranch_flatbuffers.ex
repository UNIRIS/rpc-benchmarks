defmodule RanchFlatbuffers do
  use Application

  def start(_, _) do
    children = [
      {RanchFlatbuffers.Server, [port: 8000]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: RanchFlatbuffers.Supervisor)
  end
end
