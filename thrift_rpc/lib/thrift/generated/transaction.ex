defmodule(Thrift.Generated.Transaction) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.Transaction"
  _ = "1: binary address"
  _ = "2: i8 type"
  _ = "3: i64 timestamp"
  _ = "4: transaction.Data data"
  _ = "5: binary previous_public_key"
  _ = "6: binary previous_signature"
  _ = "7: binary origin_signature"
  _ = "8: transaction.ValidationStamp validation_stamp"
  _ = "9: list<transaction.CrossValidationStamp> cross_validation_stamps"
  defstruct(address: nil, type: nil, timestamp: nil, data: nil, previous_public_key: nil, previous_signature: nil, origin_signature: nil, validation_stamp: nil, cross_validation_stamps: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.Transaction{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.Transaction{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | address: value})
    end
    defp(deserialize(<<3, 2::16-signed, value::8-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | type: value})
    end
    defp(deserialize(<<10, 3::16-signed, value::64-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | timestamp: value})
    end
    defp(deserialize(<<12, 4::16-signed, rest::binary>>, acc)) do
      case(Elixir.Thrift.Generated.Data.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | data: value})
        :error ->
          :error
      end
    end
    defp(deserialize(<<11, 5::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | previous_public_key: value})
    end
    defp(deserialize(<<11, 6::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | previous_signature: value})
    end
    defp(deserialize(<<11, 7::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | origin_signature: value})
    end
    defp(deserialize(<<12, 8::16-signed, rest::binary>>, acc)) do
      case(Elixir.Thrift.Generated.ValidationStamp.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | validation_stamp: value})
        :error ->
          :error
      end
    end
    defp(deserialize(<<15, 9::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__cross_validation_stamps(rest, [[], remaining, struct])
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__cross_validation_stamps(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | cross_validation_stamps: Enum.reverse(list)})
    end
    defp(deserialize__cross_validation_stamps(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Thrift.Generated.CrossValidationStamp.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__cross_validation_stamps(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__cross_validation_stamps(_, _)) do
      :error
    end
    def(serialize(%Thrift.Generated.Transaction{address: address, type: type, timestamp: timestamp, data: data, previous_public_key: previous_public_key, previous_signature: previous_signature, origin_signature: origin_signature, validation_stamp: validation_stamp, cross_validation_stamps: cross_validation_stamps})) do
      [case(address) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(address)::32-signed>> | address]
      end, case(type) do
        nil ->
          <<>>
        _ ->
          <<3, 2::16-signed, type::8-signed>>
      end, case(timestamp) do
        nil ->
          <<>>
        _ ->
          <<10, 3::16-signed, timestamp::64-signed>>
      end, case(data) do
        nil ->
          <<>>
        _ ->
          [<<12, 4::16-signed>> | Thrift.Generated.Data.serialize(data)]
      end, case(previous_public_key) do
        nil ->
          <<>>
        _ ->
          [<<11, 5::16-signed, byte_size(previous_public_key)::32-signed>> | previous_public_key]
      end, case(previous_signature) do
        nil ->
          <<>>
        _ ->
          [<<11, 6::16-signed, byte_size(previous_signature)::32-signed>> | previous_signature]
      end, case(origin_signature) do
        nil ->
          <<>>
        _ ->
          [<<11, 7::16-signed, byte_size(origin_signature)::32-signed>> | origin_signature]
      end, case(validation_stamp) do
        nil ->
          <<>>
        _ ->
          [<<12, 8::16-signed>> | Thrift.Generated.ValidationStamp.serialize(validation_stamp)]
      end, case(cross_validation_stamps) do
        nil ->
          <<>>
        _ ->
          [<<15, 9::16-signed, 12, length(cross_validation_stamps)::32-signed>> | for(e <- cross_validation_stamps) do
            Thrift.Generated.CrossValidationStamp.serialize(e)
          end]
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