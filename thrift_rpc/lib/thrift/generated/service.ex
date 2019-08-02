defmodule(Thrift.Generated.Service) do



  @moduledoc(false)
  defmodule(SendTransactionArgs) do
    @moduledoc(false)
    _ = "Auto-generated Thrift struct Elixir.SendTransactionArgs"
    _ = "1: transaction.Transaction tx"
    defstruct(tx: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SendTransactionArgs{})
      end
      defp(deserialize(<<0, rest::binary>>, %SendTransactionArgs{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Elixir.Thrift.Generated.Transaction.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | tx: value})
          :error ->
            :error
        end
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      def(serialize(%SendTransactionArgs{tx: tx})) do
        [case(tx) do
          nil ->
            <<>>
          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.Transaction.serialize(tx)]
        end | <<0>>]
      end
    end
    def(serialize(struct)) do
      BinaryProtocol.serialize(struct)
    end
    def(serialize(struct, :binary)) do
      BinaryProtocol.serialize(struct)
    end
    def(deserialize(binary)) do
      BinaryProtocol.deserialize(binary)
    end
  end
  defmodule(SendTransactionResponse) do
    @moduledoc(false)
    _ = "Auto-generated Thrift struct Elixir.SendTransactionResponse"
    _ = "0: transaction.Transaction success"
    defstruct(success: nil)
    @type(t :: %__MODULE__{})
    def(new) do
      %__MODULE__{}
    end
    defmodule(BinaryProtocol) do
      @moduledoc(false)
      def(deserialize(binary)) do
        deserialize(binary, %SendTransactionResponse{})
      end
      defp(deserialize(<<0, rest::binary>>, %SendTransactionResponse{} = acc)) do
        {acc, rest}
      end
      defp(deserialize(<<12, 0::16-signed, rest::binary>>, acc)) do
        case(Elixir.Thrift.Generated.Transaction.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | success: value})
          :error ->
            :error
        end
      end
      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end
      defp(deserialize(_, _)) do
        :error
      end
      def(serialize(%SendTransactionResponse{success: success})) do
        [case(success) do
          nil ->
            <<>>
          _ ->
            [<<12, 0::16-signed>> | Thrift.Generated.Transaction.serialize(success)]
        end | <<0>>]
      end
    end
    def(serialize(struct)) do
      BinaryProtocol.serialize(struct)
    end
    def(serialize(struct, :binary)) do
      BinaryProtocol.serialize(struct)
    end
    def(deserialize(binary)) do
      BinaryProtocol.deserialize(binary)
    end
  end
  defmodule(Binary.Framed.Client) do
    @moduledoc(false)
    alias(Thrift.Binary.Framed.Client, as: ClientImpl)
    defdelegate(close(conn), to: ClientImpl)
    defdelegate(connect(conn, opts), to: ClientImpl)
    defdelegate(start_link(host, port, opts \\ []), to: ClientImpl)
    def(unquote(:send_transaction)(client, tx, rpc_opts \\ [])) do
      args = %SendTransactionArgs{tx: tx}
      serialized_args = SendTransactionArgs.BinaryProtocol.serialize(args)
      ClientImpl.call(client, "send_transaction", serialized_args, SendTransactionResponse.BinaryProtocol, rpc_opts)
    end
    def(unquote(:send_transaction!)(client, tx, rpc_opts \\ [])) do
      case(unquote(:send_transaction)(client, tx, rpc_opts)) do
        {:ok, rsp} ->
          rsp
        {:error, {:exception, ex}} ->
          raise(ex)
        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end
  end
  defmodule(Binary.Framed.Server) do
    @moduledoc(false)
    require(Logger)
    alias(Thrift.Binary.Framed.Server, as: ServerImpl)
    defdelegate(stop(name), to: ServerImpl)
    def(start_link(handler_module, port, opts \\ [])) do
      ServerImpl.start_link(__MODULE__, port, handler_module, opts)
    end
    def(handle_thrift("send_transaction", binary_data, handler_module)) do
        case(Elixir.Thrift.Generated.Service.SendTransactionArgs.BinaryProtocol.deserialize(binary_data)) do
          {%Thrift.Generated.Service.SendTransactionArgs{tx: tx}, ""} ->
            try do
              rsp = handler_module.send_transaction(tx)
              (
                response = %Thrift.Generated.Service.SendTransactionResponse{success: rsp}
                {:reply, Elixir.Thrift.Generated.Service.SendTransactionResponse.BinaryProtocol.serialize(response)}
              )
            rescue
              []
            catch
              kind, reason ->
                formatted_exception = Exception.format(kind, reason, System.stacktrace())
                Logger.error("Exception not defined in thrift spec was thrown: #{formatted_exception}")
                error = Thrift.TApplicationException.exception(type: :internal_error, message: "Server error: #{formatted_exception}")
                {:server_error, error}
            end
          {_, extra} ->
            raise(Thrift.TApplicationException, type: :protocol_error, message: "Could not decode #{inspect(extra)}")
        end
    end
  end
end
