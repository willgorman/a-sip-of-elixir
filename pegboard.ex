# Based on http://golang.org/doc/play/solitaire.go
# pid = spawn(Pegboard, :solve, [Pegboard.board])
# pid <- self

defmodule Pegboard do
  @row 12 # row length + \n
  @board String.codepoints """
...........
...........
....●●●....
....●●●....
..●●●●●●●..
..●●●○●●●..
..●●●●●●●..
....●●●....
....●●●....
...........
...........
"""

  @length Enum.count(@board) #0-131

  @dirs [-1, -@row, 1, @row]

  def board do
    @board
  end

  def pos(spaces) do
    @length - Enum.count(spaces) - 1
  end

  def solve(board) do
    receive do
      from ->
        result = make_ALL_the_moves!(board, board, [])
        if (result == :so_much_win) do
          IO.puts(board)
          from <- :so_much_win
        else
          wait(from, board, result)
        end
    end
  end

  def wait(from, board, spawned) do
    receive do
      :so_much_win ->
        IO.puts(board)
        from <- :so_much_win
      {"DONE", _, _, pid, :epic_fail} ->
        # remove the spawned proc that hit a dead end and keep waiting
        remaining = List.delete(spawned, pid)
        if (Enum.empty?(remaining)) do
          Process.exit(self(), :epic_fail)
        else
          wait(from, board, remaining)
        end
    end
  end

  def move(pos, dir, board) do
    new_board = List.replace_at(board, pos, "○")
    new_board = List.replace_at(new_board, pos+dir, "○")
    new_board = List.replace_at(new_board, pos+2*dir, "●")
    {pid, ref} = Process.spawn_monitor(Pegboard, :solve, [new_board])
    pid <- self()
    pid
  end


  # found a peg, try a move
  def make_ALL_the_moves!(["●"|rest], current_board, spawned) do
    current_pos = pos(rest)
    #try any valid move in all directions
    spawns = Enum.map(@dirs, fn(dir) ->
      if valid?(current_pos, dir, current_board) do
        move(current_pos, dir, current_board)
      end
    end)

    spawns = Enum.filter(spawns, fn(x) -> x != nil end)
    make_ALL_the_moves!(rest, current_board, Enum.concat(spawned, spawns))
  end

  # no peg, keep going
  def make_ALL_the_moves!([h|t], current_board, spawned) do
    make_ALL_the_moves!(t, current_board, spawned)
  end

  # we've tried every position on the board
  def make_ALL_the_moves!([], current_board, spawned) do
    cond do
      pegs_remaining(current_board) == 1 ->
        IO.puts("WIN!!")
        :so_much_win
      Enum.empty?(spawned) ->
        # dead end
        Process.exit(self(), :epic_fail)
      true ->
        spawned
    end
  end

  def pegs_remaining(board) do
    Enum.count(board, fn(space) -> space == "●" end)
  end


  def valid?(pos, dir, board) do
    (Enum.at(board, pos+dir) == "●") and (Enum.at(board, pos+2*dir) == "○")
  end

end