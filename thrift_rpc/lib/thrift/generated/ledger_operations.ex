defmodule(Thrift.Generated.LedgerOperations) do
  @moduledoc(false)
  _ = "Auto-generated Thrift struct transaction.LedgerOperations"
  _ = "1: list<transaction.NodeMovement> node_movements"
  defstruct(node_movements: nil)
  @type(t :: %__MODULE__{})
  def(new) do
    %__MODULE__{}
  end
  defmodule(BinaryProtocol) do
    @moduledoc(false)
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.LedgerOperations{})
    end
    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.LedgerOperations{} = acc)) do
      {acc, rest}
    end
    defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__node_movements(rest, [[], remaining, struct])
    end
    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end
    defp(deserialize(_, _)) do
      :error
    end
    defp(deserialize__node_movements(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | node_movements: Enum.reverse(list)})
    end
    defp(deserialize__node_movements(<<rest::binary>>, [list, remaining | stack])) do
      case(Elixir.Thrift.Generated.NodeMovement.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__node_movements(rest, [[element | list], remaining - 1 | stack])
        :error ->
          :error
      end
    end
    defp(deserialize__node_movements(_, _)) do
      :error
    end
    def(serialize(%Thrift.Generated.LedgerOperations{node_movements: node_movements})) do
      [case(node_movements) do
        nil ->
          <<>>
        _ ->
          [<<15, 1::16-signed, 12, length(node_movements)::32-signed>> | for(e <- node_movements) do
            Thrift.Generated.NodeMovement.serialize(e)
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