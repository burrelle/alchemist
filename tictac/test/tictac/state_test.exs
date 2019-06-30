defmodule StateTest do
  use ExUnit.Case
  doctest Tictac
  alias Tictac.State

  @playerX :x
  @playerO :o
  @invalidPlayer :z

  test "new without ui" do
    assert State.new() == {:ok, %State{}}
  end

  test "new with ui" do
    ui = "UI"
    assert State.new(ui) == {:ok, %State{ui: ui}}
  end

  test "first play state" do
    for player <- [@playerO, @playerX] do
      {:ok, state} = State.event(%State{status: :initial}, {:choose_p1, player})
      assert state.status == :playing
      assert state.turn == player
    end
  end

  test "first play invalid player" do
    assert State.event(%State{status: :initial}, {:choose_p1, @invalidPlayer}) ==
             {:error, :invalid_player}
  end

  test "playing with an invalid player" do
    assert State.event(%State{status: :playing}, {:play, @invalidPlayer}) ==
             {:error, :invalid_player}
  end

  test "change turns to other player" do
    for {current, next} <- [{@playerX, @playerO}, {@playerO, @playerX}] do
      {:ok, player} = State.event(%State{status: :playing, turn: current}, {:play, current})
      assert player.turn == next
    end
  end

  test "change turns to an invalid player" do
    assert State.event(%State{status: :playing, turn: @playerO}, {:play, @invalidPlayer}) ==
             {:error, :invalid_player}
  end

  test "cannot play out of turn" do
    {error, {message, _}} = assert State.event(%State{status: :playing}, {:play})
    assert error == :error
    assert message == :invalid_state_transition
  end

  test "valid winning state" do
    for player <- [@playerO, @playerX] do
      state = State.event(%State{status: :playing}, {:check_for_winner, player})
      assert state.status == :game_over
      assert state.winner == player
    end
  end

  test "invalid winner" do
    assert State.event(%State{status: :playing}, {:check_for_winner, @invalidPlayer}) ==
             {:error, :invalid_winner_state}
  end

  test "check if game is over" do
    for {over, expectedMessage, outcome} <- [{:not_over, :ok, nil}, {:game_over, :ok, :tie}] do
      {actualMessage, state} = State.event(%State{status: :playing}, {:game_over?, over})
      assert expectedMessage == actualMessage
      assert state.winner == outcome
    end
  end

  test "invalid game is over" do
    assert State.event(%State{status: :playing}, {:game_over?, :incorrect}) ==
             {:error, :invalid_game_over_status}
  end
end
