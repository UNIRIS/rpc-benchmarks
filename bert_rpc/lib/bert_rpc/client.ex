defmodule BertRpc.Client do



  def multi_calls(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    IO.inspect(1..nb
    |> Enum.map(fn _ -> Task.async fn -> BertRpc.Client.do_call(tx) end end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok


  end

  def delay_multi_calls(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    IO.inspect(1..nb
    |> Enum.map(fn _ ->
      t = Task.async fn -> BertRpc.Client.do_call(tx) end
      Process.sleep(100)
      t
    end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok
  end


  def do_call(tx) do
    start = System.os_time(:millisecond)
    conn = BertGate.Client.connect("localhost", %{port: 9000})
    BertGate.Client.call(conn,:'Transaction',:send_transaction,[tx])
    System.os_time(:millisecond) - start
  end

  defp create_transaction(pub, sig) do
    node_movements = [
      %{fee: 0.5, node_public_key: pub, is_welcome: true},
      %{fee: 0.5, node_public_key: pub, is_coordinator: true}
    ]

    node_movements =
      node_movements ++
        for _i <- 1..5, do: %{fee: 0.5, node_public_key: pub, is_data_giver: true}

    node_movements =
      node_movements ++
        for _i <- 1..200, do: %{fee: 0.5, node_public_key: pub, is_cross_validation: true}

    stamps =
      for _i <- 1..200,
          do: %{
            public_key: pub,
            signature: sig
          }

    %{
      address: hash(pub),
      type: 1,
      data: %{
        ledgers: %{
          uco: %{
            to: pub,
            amount: 10
          }
        }
      },
      timestamp: :os.system_time(:millisecond),
      prev_public_key: pub,
      prev_signature: sig,
      origin_signature: sig,
      validation_stamp: %{
        proof_of_work: pub,
        proof_of_integrity: hash("fake proof of integrity"),
        ledger_operations: %{
          node_movements: node_movements
        }
      },
      cross_validation_stamps: stamps
    }
  end

  defp hash(data), do: :crypto.hash(:sha256, data)
  defp sign(key, data), do: :crypto.sign(:ecdsa, :sha256, hash(data), [key, :secp256r1])
end
