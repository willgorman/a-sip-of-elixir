# Based on http://golang.org/doc/play/solitaire.go
# Pegboard.solve(Pegboard.board)

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
    result = make_ALL_the_moves!(board, board)
    if (result == :so_much_win) do
      IO.puts(board)
      :so_much_win
    end
  end

  def move(pos, dir, board) do
    new_board = List.replace_at(board, pos, "○")
    new_board = List.replace_at(new_board, pos+dir, "○")
    new_board = List.replace_at(new_board, pos+2*dir, "●")
    Pegboard.solve(new_board)
  end

  def try_move(pos, dir, board) do
    if (valid?(pos, dir, board)) and (move(pos, dir, board) == :so_much_win) do
      :true
    else
      :false
    end
  end

  # found a peg, try a move
  def make_ALL_the_moves!(["●"|rest], current_board) do
    current_pos = pos(rest)
    #try any valid move in all directions
    cond do
      try_move(current_pos, -1, current_board) -> :so_much_win
      try_move(current_pos, -@row, current_board) -> :so_much_win
      try_move(current_pos, 1, current_board) -> :so_much_win
      try_move(current_pos, @row, current_board) -> :so_much_win
      true ->
        make_ALL_the_moves!(rest, current_board)
    end
  end

  # no peg, keep going
  def make_ALL_the_moves!([h|t], current_board) do
    make_ALL_the_moves!(t, current_board)
  end

  # we've tried every position on the board
  def make_ALL_the_moves!([], current_board) do
    cond do
      pegs_remaining(current_board) == 1 ->
        IO.puts("WIN!!")
        :so_much_win
      true ->
        :donezo
    end
  end

  def pegs_remaining(board) do
    Enum.count(board, fn(space) -> space == "●" end)
  end


  def valid?(pos, dir, board) do
    (Enum.at(board, pos+dir) == "●") and (Enum.at(board, pos+2*dir) == "○")
  end
end