defmodule(Thrift.Generated.NodeMovement) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.NodeMovement"
  _ = "1: binary node_public_key"
  _ = "2: double fee"
  _ = "3: bool is_coordinator"
  _ = "4: bool is_welcome"
  _ = "5: bool is_data_giver"
  _ = "6: bool is_cross_validation"
  defstruct(node_public_key: nil, fee: nil, is_coordinator: false, is_welcome: false, is_data_giver: false, is_cross_validation: false)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.NodeMovement{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.NodeMovement{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | node_public_key: value})
    end
    defp(deserialize(<<4, 2::16-signed, 0::1, 2047::11, 0::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | fee: :inf})
    end
    defp(deserialize(<<4, 2::16-signed, 1::1, 2047::11, 0::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | fee: :"-inf"})
    end
    defp(deserialize(<<4, 2::16-signed, sign::1, 2047::11, frac::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | fee: %Thrift.NaN{sign: sign, fraction: frac}})
    end
    defp(deserialize(<<4, 2::16-signed, value::float-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | fee: value})
    end
    defp(deserialize(<<2, 3::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_coordinator: true})
    end
    defp(deserialize(<<2, 3::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_coordinator: false})
    end
    defp(deserialize(<<2, 4::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_welcome: true})
    end
    defp(deserialize(<<2, 4::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_welcome: false})
    end
    defp(deserialize(<<2, 5::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_data_giver: true})
    end
    defp(deserialize(<<2, 5::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_data_giver: false})
    end
    defp(deserialize(<<2, 6::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_cross_validation: true})
    end
    defp(deserialize(<<2, 6::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | is_cross_validation: false})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Thrift.Generated.NodeMovement{node_public_key: node_public_key, fee: fee, is_coordinator: is_coordinator, is_welcome: is_welcome, is_data_giver: is_data_giver, is_cross_validation: is_cross_validation})) do
      [case(node_public_key) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(node_public_key)::32-signed>> | node_public_key]
      end, case(fee) do
        nil ->
          <<>>
        _ ->
          [<<4, 2::16-signed>> | case(fee) do
            :inf ->
              <<0::1, 2047::11, 0::52>>
            :"-inf" ->
              <<1::1, 2047::11, 0::52>>
            %Thrift.NaN{sign: sign, fraction: frac} ->
              <<sign::1, 2047::11, frac::52>>
            _ ->
              <<fee::float-signed>>
          end]
      end, case(is_coordinator) do
        nil ->
          <<>>
        false ->
          <<2, 3::16-signed, 0>>
        true ->
          <<2, 3::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :is_coordinator on Thrift.Generated.NodeMovement must be true, false, or nil")
      end, case(is_welcome) do
        nil ->
          <<>>
        false ->
          <<2, 4::16-signed, 0>>
        true ->
          <<2, 4::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :is_welcome on Thrift.Generated.NodeMovement must be true, false, or nil")
      end, case(is_data_giver) do
        nil ->
          <<>>
        false ->
          <<2, 5::16-signed, 0>>
        true ->
          <<2, 5::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :is_data_giver on Thrift.Generated.NodeMovement must be true, false, or nil")
      end, case(is_cross_validation) do
        nil ->
          <<>>
        false ->
          <<2, 6::16-signed, 0>>
        true ->
          <<2, 6::16-signed, 1>>
        _ ->
          raise(Thrift.InvalidValueError, "Optional boolean field :is_cross_validation on Thrift.Generated.NodeMovement must be true, false, or nil")
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