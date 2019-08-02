defmodule ThriftRpc.Client do

  require Logger


  def multi_call(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    IO.inspect(1..nb
    |> Enum.map(fn _ -> Task.async fn -> ThriftRpc.Client.do_call(tx) end end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok

  end

  def delay_multi_call(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    IO.inspect(1..nb
    |> Enum.map(fn _ ->
      t = Task.async fn -> ThriftRpc.Client.do_call(tx) end
      Process.sleep(100)
      t
    end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok

  end

  def do_call(tx) do
    start = System.os_time(:millisecond)
    {:ok, client} = Thrift.Generated.Service.Binary.Framed.Client.start_link("localhost", 5000)
    Thrift.Generated.Service.Binary.Framed.Client.send_transaction(client, tx)
    Thrift.Generated.Service.Binary.Framed.Client.close(client)
    System.os_time(:millisecond) - start
  end

  defp create_transaction(pub, sig) do

    node_movements = [
      %Thrift.Generated.NodeMovement{ fee: 0.5, node_public_key: pub , is_welcome: true },
      %Thrift.Generated.NodeMovement{ fee: 0.5, node_public_key: pub , is_coordinator: true },
    ]
    node_movements = node_movements ++ for _i <- 1..50, do: %Thrift.Generated.NodeMovement{ fee: 0.5, node_public_key: pub , is_data_giver: true}
    node_movements = node_movements ++ for _i <- 1..200, do: %Thrift.Generated.NodeMovement{ fee: 0.5, node_public_key: pub , is_cross_validation: true}

    stamps = for _i <- 1..200, do: %Thrift.Generated.CrossValidationStamp{
      public_key: pub ,
      signature: sig ,
    }

    %Thrift.Generated.Transaction{
      address: hash(pub) ,
      type: 1,
      data: %Thrift.Generated.Data{
        ledgers: %Thrift.Generated.Ledgers{
          uco: %Thrift.Generated.UCOLedger{
            to: pub ,
            amount: 10
          }
        }
      },
      timestamp: :os.system_time(:millisecond),
      previous_public_key: pub ,
      previous_signature: sig ,
      origin_signature: sig ,
      validation_stamp: %Thrift.Generated.ValidationStamp{
        proof_of_work: pub ,
        proof_of_integrity: hash("fake proof of integrity") ,
        ledger_operations: %Thrift.Generated.LedgerOperations{
          node_movements: node_movements
        }
      },
      cross_validation_stamps: stamps
    }
  end

  defp hash(data), do: :crypto.hash(:sha256, data)
  defp sign(key, data), do: :crypto.sign(:ecdsa, :sha256, hash(data), [key, :secp256r1])

end
