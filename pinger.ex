:net_kernel.start([:pinger])

Node.connect(:'ponger@MAC-WG9059.local')
# not sure why but it fails if we try to find the
# name immediately after connecting
:timer.sleep(500)
ponger_pid = :global.whereis_name(:ponger)


defmodule Pinger do
  def ping(ponger_pid) do
    ponger_pid <- {:ping, self}
    receive do
      {:pong, ponger_pid} ->
        IO.puts("PONG!\n\n\n")
        :timer.sleep(1000)
        ponger_pid <- {:ping, self}
    end
    ping(ponger_pid)
  end
end

pinger_pid = spawn(Pinger, :ping, [ponger_pid])


