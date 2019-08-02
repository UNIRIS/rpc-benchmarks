defmodule RanchFlatbuffers.Client do

  def multi_calls(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    schema = File.read!("schema.fbs") |> Eflatbuffers.Schema.parse!

    IO.inspect(1..nb
    |> Enum.map(fn _ -> Task.async fn -> RanchFlatbuffers.Client.do_call(tx, schema) end end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok
  end

  def delay_multi_calls(nb) do
    {pub, pv} = :crypto.generate_key(:ecdh, :secp256r1)
    tx = create_transaction(pub, sign(pv, "fake transaction"))

    schema = File.read!("schema.fbs") |> Eflatbuffers.Schema.parse!

    IO.inspect(1..nb
    |> Enum.map(fn _ ->
      t = Task.async fn -> RanchFlatbuffers.Client.do_call(tx, schema) end
      Process.sleep(100)
      t
    end)
    |> Enum.map(fn t -> Task.await(t, :infinity) end), limit: :infinity)
    :ok
  end

  def do_call(tx, schema) do

    start = System.os_time(:millisecond)

    {:ok, socket} = :gen_tcp.connect('localhost', 8000, [:binary, packet: 0, active: :once])
    tx_raw = Eflatbuffers.write!(tx, schema)
    tx_size = byte_size(tx_raw)
    data = <<"01">> <> <<tx_size::32>> <> tx_raw
    :ok = :gen_tcp.send(socket, data)
    res = loop_receive()
    :gen_tcp.close(socket)
    Eflatbuffers.read!(res, schema)

    System.os_time(:millisecond) - start
  end

  defp loop_receive(buffer \\ %{}) do
    receive do
      {:tcp, socket, data} ->
        case data do
          <<tag::binary-size(2), res_size::32, res::binary>> when tag == "01" ->
            :inet.setopts(socket,[{:active, :once}])
            loop_receive(%{max_size: res_size, data: res})
          <<tag::binary-size(3), err_code::8>> when tag == "ERR" and err_code in [<<401>>, <<404>>] ->
            {:error, err_code}
          _ ->
            remaining = buffer.max_size - byte_size(buffer.data)
            if byte_size(data) == remaining do
              buffer.data <> data
            else
              :inet.setopts(socket,[{:active, :once}])
              loop_receive(%{buffer | data: buffer.data <> data})
            end
          end
    end
  end

  defp create_transaction(pub, sig) do

    node_movements = [
      %{ fee: 0.5, node_public_key: pub , is_welcome: true },
      %{ fee: 0.5, node_public_key: pub , is_coordinator: true },
    ]
    node_movements = node_movements ++ for _i <- 1..50, do: %{ fee: 0.5, node_public_key: pub , is_data_giver: true}
    node_movements = node_movements ++ for _i <- 1..200, do: %{ fee: 0.5, node_public_key: pub , is_cross_validation: true}

    stamps = for _i <- 1..200, do: %{
      public_key: pub ,
      signature: sig ,
    }

    %{
      address: hash(pub) ,
      type: 1,
      data: %{
        ledgers: %{
          uco: %{
            to: pub ,
            amount: 10
          }
        }
      },
      timestamp: :os.system_time(:millisecond),
      prev_public_key: pub ,
      prev_signature: sig ,
      origin_signature: sig ,
      validation_stamp: %{
        proof_of_work: pub ,
        proof_of_integrity: hash("fake proof of integrity") ,
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
