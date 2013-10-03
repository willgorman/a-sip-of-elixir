defmodule Guards do
  def guarded(x) when x >= 0 do; end

  def guarded(x) when is_number(x) do
    "x is negative"
  end
end

defmodule NoWai do
  def nope(0) do; end
  def nope(1) do; end
  def nope(2) do; end
  # ... Are we really doing this?
  def nope(9) do; end
  def nope(x) do
    "I'm at least 10 (or negative but whatever)"
  end
end

