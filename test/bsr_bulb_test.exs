defmodule BSRBulbTest do
  use ExUnit.Case

  test "creating a new bsr_bulb client for a given device" do
    {:ok, pid} = BSRBulb.Client.start("/dev/pts/10")
    assert is_pid(pid)
  end
end
