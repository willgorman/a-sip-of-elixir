defmodule Macros do
  defmacro example(x) do
    IO.inspect x
  end

  defmacro inc do
    {:fn, [],
     [[do: {:->, [],
      [{[{:x, [], nil}], [],
        {:+, [], [{:x, [], nil}, 1]}}]}]]}
  end
end

require Macros
Macros.example(fn(x) -> x + 1 end)


inc = Macros.inc
inc.(3) # => 4

# {:fn, [line: 6],
#  [[do: {:->, [line: 6],
#     [{[{:x, [line: 6], nil}], [line: 6],
#       {:+, [line: 6], [{:x, [line: 6], nil}, 1]}}]}]]}


# quote/unquote

defmodule Macros do
  defmacro example(x) do
    IO.inspect x
  end

  defmacro inc do
    quote do: fn(x) -> x + 1 end
  end
end

# macros can add functions to modules

defmodule BlankSlate do
  defmacro defn(name, body) do
    quote do
      def unquote(name)(arg) do
        func = unquote(body)
        func.(arg)
      end
    end
  end
end

defmodule B do
  require BlankSlate
  BlankSlate.defn(:m, fn(x) -> x + 1 end)
end


defmodule Example do
  defmacro unless(condition, body) do
    quote do
      if(!unquote(condition), unquote(body))
    end
  end
end

require Example
Example.unless(1 + 1 == 3) do
 IO.puts("Not true")
end

