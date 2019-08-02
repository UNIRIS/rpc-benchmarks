defmodule(Thrift.Generated.UCOLedger) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.UCOLedger"
  _ = "1: binary to"
  _ = "2: double amount"
  defstruct(to: nil, amount: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.UCOLedger{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.UCOLedger{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size), rest::binary>>, acc)) do
      deserialize(rest, %{acc | to: value})
    end
    defp(deserialize(<<4, 2::16-signed, 0::1, 2047::11, 0::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | amount: :inf})
    end
    defp(deserialize(<<4, 2::16-signed, 1::1, 2047::11, 0::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | amount: :"-inf"})
    end
    defp(deserialize(<<4, 2::16-signed, sign::1, 2047::11, frac::52, rest::binary>>, acc)) do
      deserialize(rest, %{acc | amount: %Thrift.NaN{sign: sign, fraction: frac}})
    end
    defp(deserialize(<<4, 2::16-signed, value::float-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | amount: value})
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    def(serialize(%Thrift.Generated.UCOLedger{to: to, amount: amount})) do
      [case(to) do
        nil ->
          <<>>
        _ ->
          [<<11, 1::16-signed, byte_size(to)::32-signed>> | to]
      end, case(amount) do
        nil ->
          <<>>
        _ ->
          [<<4, 2::16-signed>> | case(amount) do
            :inf ->
              <<0::1, 2047::11, 0::52>>
            :"-inf" ->
              <<1::1, 2047::11, 0::52>>
            %Thrift.NaN{sign: sign, fraction: frac} ->
              <<sign::1, 2047::11, frac::52>>
            _ ->
              <<amount::float-signed>>
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