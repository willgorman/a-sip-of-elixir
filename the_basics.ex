# anonymous functions
triple = fn(x) -> x * 3 end
triple.(3) # => 9


# modules
defmodule Tripler do
  def triple(x) do
    x * 3
  end
end

Tripler.triple 3 # => 9


# atoms
:an_atom

# lists
["cat", "dog", "platypus"]

# tuples
{:is_it, :toople, :or, :tupple?}


# calling Erlang functions
:calendar.local_time
# => {{2013, 10, 29}, {19, 23, 36}}

# keyword lists
kw = [{1, 2}, {:a, "b"}]
kw[1] # => 2
kw[:a] # => "b"


# no hash dict literals

hd = HashDict.new([{:a, 1}, {:b, 2}])
# => #HashDict<[a: 1, b: 2]>

# strings
"single line"

"""multi
line
"""

"concat" <> "enated"

x = "polated"
"inter#{x}"

# regular expressions
Regex.run %r/foo/, "foo bar" # => ["foo"]

