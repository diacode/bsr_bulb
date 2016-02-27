defmodule CommandsTest do
  use ExUnit.Case

  test "SwitchOn" do
    {:ok, expected_bytes} = "01fe0000538310000000000050ff0000" |> to_bytes
    assert expected_bytes == BSRBulb.Command.SwitchOn.new
  end

  test "SwitchOff" do
    {:ok, expected_bytes} = "01fe0000538310000000000050000000" |> to_bytes
    assert expected_bytes == BSRBulb.Command.SwitchOff.new
  end

  test "SetColor Red" do
    {:ok, expected_bytes} = "01fe0000538310000000ff0050000000" |> to_bytes
    red = "#ff0000"
    assert expected_bytes == BSRBulb.Command.SetColor.new(red)
  end

  test "SetColor Blue" do
    {:ok, expected_bytes} = "01fe00005383100000ff000050000000" |> to_bytes
    red = "#0000ff"
    assert expected_bytes == BSRBulb.Command.SetColor.new(red)
  end

  defp to_bytes(hex_string) do
    Base.decode16(hex_string, case: :lower)
  end
end
