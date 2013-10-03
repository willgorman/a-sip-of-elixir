# basic spawn
defmodule Echoer do
  def echo do
    receive do
      {:hello, x} ->
        IO.puts "Echo #{inspect(x)}"
    end
  end
end

pid = spawn(Echoer, :echo, [])

# send a message
pid <- :no_match # => :no_match
pid <- {:hello, :process} # => {:hello, :process}
# "Echo :process"


# now it's done
pid <- {:hello, :again?} # => {:hello, :again?}


# recursion to keep alive (tail recursion!)
defmodule Echoer do
  def echo do
    receive do
      {:hello, x} ->
        IO.puts "Echo #{inspect(x)}"
    end
    echo
  end
end

# example with parameters?

# passing pid to allow processes to return back
defmodule Child do
  def question do
    receive do
      {:yo_dawg, caller} ->
        caller <- :i_heard_you_liked_processes
    end
  end
end

pid = spawn(TiredMeme, :create_child, [])

# registry
Process.register(pid, :memorable_name_goes_here)
:memorable_name_goes_here <- :message


# queueing

defmodule Q do
  def wait_a_bit do
    :timer.sleep 10000

    handle_msgs
  end

  def handle_msgs do
    receive do
      x -> IO.puts("Got #{inspect(x)}")
    end
    handle_msgs
  end
end