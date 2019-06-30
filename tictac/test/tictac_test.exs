defmodule TictacTest do
  use ExUnit.Case
  doctest Tictac
  import Tictac
  alias Tictac.Square

  @playerX :x
  @playerO :o
  @board Square.new_board()

  def square_factory(col, row) do
    %Square{col: col, row: row}
  end

  test "check_player" do
    assert check_player(:x) == {:ok, @playerX}
    assert check_player(:o) == {:ok, @playerO}
    assert check_player(:z) == {:error, :invalid_player}
  end

  test "invalid play_piece" do
    assert place_piece(@board, square_factory(5, 5), @playerX) == {:error, :invalid_location}
  end

  test "occupied play_piece :x" do
    place = square_factory(1, 1)
    {:ok, new_board} = place_piece(@board, place, @playerX)
    assert new_board[place] == @playerX
  end

  test "occupied play_piece :o" do
    place = square_factory(1, 1)
    {:ok, new_board} = place_piece(@board, place, @playerO)
    assert new_board[place] == @playerO
  end
end
