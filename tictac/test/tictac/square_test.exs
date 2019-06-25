defmodule SquareTest do
  use ExUnit.Case
  doctest Tictac
  alias Tictac.Square

  test "valid new" do
    {:ok, square} = Square.new(1, 1)
    assert square == %Square{row: 1, col: 1}
  end

  test "invalid new" do
    invalid = Square.new(5, 5)
    assert invalid == {:error, :invalid_square}
  end

  test "new board" do
    board = Square.new_board()
    assert Enum.count(board) == 9
    assert Enum.each(board, fn {_k, v} -> assert v == :empty end)
  end

  test "squares" do
    squares = Square.squares()
    assert map_size(squares) == 3
  end
end
