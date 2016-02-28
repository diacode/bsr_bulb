defmodule BSRBulb.Client do
  defmodule State do
    defstruct [:device, :switch, :color]
  end

  use ExActor.GenServer

  defcall switch_on, state: state do
    state = %State{state | switch: :on}
    do_request(BSRBulb.Command.SwitchOn.new(), state)
  end

  defcall switch_off, state: state do
    state = %State{state | switch: :off}
    do_request(BSRBulb.Command.SwitchOff.new(), state)
  end

  defcall set_color(hexadecimal_color), state: state do
    state = %State{state | color: hexadecimal_color}
    do_request(BSRBulb.Command.SetColor.new(hexadecimal_color), state)
  end

  defstart start(device) do
    device = :serial.start([speed: 115200, open: :erlang.bitstring_to_list(device)])
    initial_state(%State{device: device, switch: :off, color: "#ffffff"})
  end

  defp do_request(request_bytes, state) do
    send(state.device, {:send, request_bytes})
    _response = receive do
      {:data, data} -> IO.inspect data
    after
      1 -> :timeout
    end
    IO.inspect state
    set_and_reply(state, :ok)
  end
end
