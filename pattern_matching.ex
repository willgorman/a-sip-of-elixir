# function dispatch

defmodule Dispatch do
  def a_fn({:this, x}) do
    "You can go with this: #{x}"
  end

  def a_fn({:that, y}) do
    "Or you can go with that: #{y}"
  end
end

Dispatch.a_fn({:this, 1})
# -> "You can go with this: 1"

Dispatch.a_fn({:that, 2})
# -> "Or you can go with that: 2"

# conditionals

defmodule Case do
  def a_case(arg) do
    case arg do
      :atom -> "An atom"
      42 -> "A number"
      [1, 2, x] -> "x is #{x}"
      [head|tail] ->
        "tail: #{Enum.count(tail)}"
      {a, b} -> "a: #{a}"
    end
  end
end

# message handling
defmodule Msg do
  def handle do
    receive do
      :hello -> :how_are_you?
      {:hi, x} -> IO.puts(x)
      [1, y, 3] -> IO.puts(b)
    end
  end
end

# variables
some_fn = fn(x) ->
  {:here, :is, x}
end

{:here, :is, x} = some_fn.("X!")

x # => "X!"

# watch out, any variable will be rebound if used in a sucessful pattern match
x = 1
y = 2
case y do
  x -> "Matched x"
  true -> "No match"
end
x # => 2

#use ^ to match on the value of the variable
x = 1
y = 2
case y do
  ^x -> "Matched x"
  true -> "No match"
end

# records
defrecord Human, name: nil
p = Human.new(name: "Finn")
defmodule Quotes do
  def speak(Human[name: "Finn"]) do
    "Mathematical!"
  end

  def speak(Human[name: "Fiona"]) do
    "I'm all about swords!"
  end
end

# recursion
defmodule Recur do
  def countdown(0) do
    IO.puts "Blast off!"
  end

  def countdown(x) do
    IO.puts "#{x}..."
    countdown(x - 1)
  end
end

defmodule ListProcessing do
  def recur([]) do; end

  def recur([head|tail]) do
    IO.puts("#{inspect(head)}")
    recur(tail)
  end
end

# matches the _first_ clause that qualifies, so watch out for changing order
# when refactoring
defmodule MatchOrder do
  def func([h|t]) do
    IO.puts("#{inspect(t)}")
  end

  def func([x, y]) do
    IO.puts("#{inspect(y)}")
  end
end

MatchOrder.func[1, 2]  # => "[2]"

defmodule MatchOrder do
  def func([x, y]) do
    IO.puts("#{inspect(y)}")
  end

  def func([h|t]) do
    IO.puts("#{inspect(t)}")
  end
end

MatchOrder.func[1, 2]  # => "2"