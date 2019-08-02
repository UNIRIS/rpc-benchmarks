defmodule(Thrift.Generated.ValidationStamp) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.ValidationStamp"
  _ = "1: binary proof_of_work"
  _ = "2: binary proof_of_integrity"
  _ = "3: transaction.LedgerOperations ledger_operations"
  defstruct(proof_of_work: nil, proof_of_integrity: nil, ledger_operations: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.ValidationStamp{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.ValidationStamp{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | proof_of_work: value})
    end
    defp(deserialize(<<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | proof_of_integrity: value})
    end
    defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
      case(Elixir.Thrift.Generated.LedgerOperations.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | ledger_operations: value})
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
    def(serialize(%Thrift.Generated.ValidationStamp{proof_of_work: proof_of_work, proof_of_integrity: proof_of_integrity, ledger_operations: ledger_operations})) do
      [case(proof_of_work) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(proof_of_work)::32-signed>> | proof_of_work]
      end, case(proof_of_integrity) do
        nil ->
          <<>>
        _ ->
          [<<11, 2::16-signed, byte_size(proof_of_integrity)::32-signed>> | proof_of_integrity]
      end, case(ledger_operations) do
        nil ->
          <<>>
        _ ->
          [<<12, 3::16-signed>> | Thrift.Generated.LedgerOperations.serialize(ledger_operations)]
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