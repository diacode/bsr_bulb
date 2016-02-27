defmodule BSRBulb.Command do
  @base_cmd "01fe000053831000"

  # hex_cmd is the part of the command that changes
  def new(hex_cmd) do
    full_hex_cmd = @base_cmd <> hex_cmd
    {:ok, bytes} = Base.decode16(full_hex_cmd, case: :lower)
    bytes
  end
end

defmodule BSRBulb.Command.SwitchOn do
  def new() do
    BSRBulb.Command.new("0000000050" <> "ff" <> "0000")
  end
end

defmodule BSRBulb.Command.SwitchOff do
  def new() do
    BSRBulb.Command.new("0000000050" <> "00" <> "0000")
  end
end

defmodule BSRBulb.Command.SetColor do
  def new(hexadecimal_color) do
    # Clean the received string and fetch each color component
    [red, green, blue] = String.replace(hexadecimal_color, "#", "")
      |> String.to_char_list
      |> Enum.chunk(2)
      |> Enum.map(fn x -> to_string(x) end)

    # Here is where the magic happens:
    # - First and last string are always the same for the color commands
    # - Color should go in GBR format instead of RGB. Chinese WTF
    hex_cmd = green <> blue <> red <> "0050000000"

    BSRBulb.Command.new(hex_cmd)
  end
end
