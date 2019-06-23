defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italicizes" do
    string = "Something *important*"
    assert AlchemyMarkdown.to_html(string) =~ "<em>important</em>"
  end

  test "expands big tags" do
    string = "Some ++big++ words"
    assert AlchemyMarkdown.to_html(string) =~ "<big>big</big>"
  end

  test "expands small tags" do
    string = "Some --small-- words"
    assert AlchemyMarkdown.to_html(string) =~ "<small>small</small>"
  end

  test "expand hr tags" do
    string1 = "Stuff over the line\n---"
    string2 = "Stuff over the line\n***"
    string3 = "Stuff over the line\n* * *"
    string4 = "Stuff over the line\n- - -"
    string5 = "Stuff over the line- - -"

    Enum.each(
      [string1, string2, string3, string4],
      fn str ->
        assert AlchemyMarkdown.hrs(str) ==
                 "Stuff over the line\n<hr />"
      end
    )

    assert AlchemyMarkdown.hrs(string5) == string5
  end
end
