defmodule Multi do
  def one(init) do
    IO.puts("hi!!!")
    receive do
      x ->
        IO.puts(init)
        two
    end
  end

  def two do
    receive do
      :ok -> IO.puts(:ok)
    end
    two
  end

end