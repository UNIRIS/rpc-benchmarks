defmodule RanchFlatbuffers.Handler do
  use GenServer

  @operation_codes ["01"]

  def start_link(ref, socket, transport, _opts) do
    schema = File.read!("schema.fbs") |> Eflatbuffers.Schema.parse!
    pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, socket, transport, schema])
    {:ok, pid}
  end

  def init(ref, socket, transport, schema) do
    :ok = :ranch.accept_ack(ref)
    :ok = transport.setopts(socket, [{:active, :once}, {:packet, 0}, {:reuseaddr, true}])
    :gen_server.enter_loop(__MODULE__, [], %{schema: schema, transport: transport, req_buffer: %{}})
  end

  def handle_info({:tcp, socket, data}, state = %{schema: schema, transport: transport, req_buffer: req_buffer}) do
    socket_id = :erlang.port_to_list(socket)

    case data do
      <<msg_id::binary-size(2), msg_size::32, msg_chunk::binary>> when msg_id in @operation_codes ->
        req_buffer =
          Map.put(req_buffer, socket_id, %{data: msg_chunk, id: msg_id, size: msg_size})

        transport.setopts(socket, [{:active, :once}])
        {:noreply, Map.put(state, :req_buffer, req_buffer)}

      chunk ->
        case Map.get(req_buffer, socket_id) do
          nil ->
            transport.send(socket, <<"ERR", 401>>)
            {:noreply, state}

          socket_buf ->
            remaining = socket_buf.size - byte_size(socket_buf.data)
            if remaining > 0 and byte_size(chunk) == remaining do
              req_data = Eflatbuffers.read!(socket_buf.data <> chunk, schema)
              case handle_operation(socket_buf.id, req_data) do
                nil ->
                  state = Map.put(state, :req_buffer, Map.delete(state.req_buffer, socket_id))
                  {:noreply, state}
                data ->
                  res = Eflatbuffers.write!(data, schema)
                  res_size = byte_size(res)
                  state = Map.put(state, :req_buffer, Map.delete(state.req_buffer, socket_id))
                  :ok = transport.send(socket, socket_buf.id <> <<res_size::32>> <> res)
                  {:noreply, state}
              end
            else
              state = put_in(state, [:req_buffer, socket_id, :data], socket_buf.data <> chunk)
              transport.setopts(socket, [{:active, :once}])
              {:noreply, state}
            end
        end
    end
  end

  def handle_info({:tcp_closed, socket}, state = %{transport: transport}) do
    transport.close(socket)
    {:stop, :normal, state}
  end

  defp handle_operation("01", data) do
    data
  end
end
