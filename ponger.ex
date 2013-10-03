:net_kernel.start([:ponger])


defmodule Ponger do
  def pong do
    receive do
      {:ping, pinger} ->
        IO.puts("\n\n\nPING!")
        :timer.sleep(1000)
        pinger <- {:pong, self}
    end
    pong
  end
end

ponger_pid = spawn(Ponger, :pong, [])
:global.register_name(:ponger, ponger_pid)