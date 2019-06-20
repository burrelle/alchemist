defmodule Greeting do
  def greet do
    name = IO.gets("Could I get your name?\n")

    case String.downcase(String.trim(name)) do
      "evan" ->
        "It's another me!"

      _ ->
        "Hello #{String.trim(name)}"
    end
  end
end
