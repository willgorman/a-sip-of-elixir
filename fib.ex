
defmodule Fib do
  def fib do
    receive do
      {stack, i} when is_list(stack) ->
        IO.puts i
        [to|rest] = stack
        IO.puts (inspect(stack))
        cond do
          i == 0 ->
            to <- {0, rest}
          i == 1 ->
            to <- {1, rest}
          true ->
            n1 = spawn(Fib, :fib, [])
            n2 = spawn(Fib, :fib, [])
            n1 <- {[self() | stack], i-1}
            n2 <- {[self() | stack], i-2}
        end
      {r, stack} when is_number(r) ->
        IO.puts "WHT"
        [to|rest] = stack
        to <- {r, rest}
      {from, i} ->
        IO.puts "NOW HERE"
        cond do
          i == 0 ->
            from <- 0
          i == 1 ->
            from <- 1
          true ->
            n1 = spawn(Fib, :fib, [])
            n2 = spawn(Fib, :fib, [])
            n1 <- {[self(), from], i-1}
            n2 <- {[self(), from], i-2}
        end
    end
    fib()
  end

end