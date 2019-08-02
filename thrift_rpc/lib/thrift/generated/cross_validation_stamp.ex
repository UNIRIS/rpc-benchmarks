defmodule(Thrift.Generated.CrossValidationStamp) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.CrossValidationStamp"
  _ = "1: binary signature"
  _ = "2: binary public_key"
  defstruct(signature: nil, public_key: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.CrossValidationStamp{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.CrossValidationStamp{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | signature: value})
    end
    defp(deserialize(<<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | public_key: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Thrift.Generated.CrossValidationStamp{signature: signature, public_key: public_key})) do
      [case(signature) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(signature)::32-signed>> | signature]
      end, case(public_key) do
        nil ->
          <<>>
        _ ->
          [<<11, 2::16-signed, byte_size(public_key)::32-signed>> | public_key]
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