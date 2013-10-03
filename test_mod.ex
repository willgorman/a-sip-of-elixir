defmodule MyTest do
  def something(x) do
    IO.puts("One argument")
  end

  def something(x, y) do
    IO.puts("Two arguments")
  end
end

defmodule Atoms do
  def atom_match(:this, x) do
    IO.puts "this"
  end

  def atom_match(:that, x) do
    IO.puts "that"
  end
end

defmodule Legal do
  def atom_match(:other, x) do
    IO.puts "other"
  end

  def atom_match(_, x) do
    IO.puts "yep"
  end

  def variable(^x = 20) do
    IO.puts "?"
  end
end