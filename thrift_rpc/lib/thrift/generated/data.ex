defmodule(Thrift.Generated.Data) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.Data"
  _ = "1: transaction.Ledgers ledgers"
  defstruct(ledgers: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.Data{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.Data{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Elixir.Thrift.Generated.Ledgers.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | ledgers: value})
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
    def(serialize(%Thrift.Generated.Data{ledgers: ledgers})) do
      [case(ledgers) do
        nil ->
          <<>>
        _ ->
          [<<12, 1::16-signed>> | Thrift.Generated.Ledgers.serialize(ledgers)]
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