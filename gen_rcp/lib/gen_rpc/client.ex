defmodule GenRpc.Client do

  def multi_call(nb) do

    IO.inspect(1..nb
    |> Enum.map(fn _ -> Task.async fn -> GenRpc.Client.do_call() end end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok
  end

  def do_call() do
    :gen_rpc.call(:"test@mac", GenRpc.Transaction, :send_transaction, [1])
  end

end
