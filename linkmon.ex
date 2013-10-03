defmodule Monitor do
  def mon_and_wait do
    receive do
      :go ->
        IO.puts("1")
        {pid, ref} = Process.spawn_monitor(Monitor, :monitee, [])
        IO.puts("2")
        pid <- :mon
    end

    IO.puts("3")
    receive do
      {down, ref, proc, pid2, reason} ->
        IO.puts("#{down} #{reason}")
    end
  end

  def monitee do
    IO.puts("4")
    receive do
      :mon ->
        IO.puts("5")
        :timer.sleep(2000)
        IO.puts("GOODBYE")
        Process.exit(self(), :goodbye)
    end
  end

end