defmodule MiniMarkdown do
  def to_html(text) do
    text
    |> h1
    |> h2
    |> p
    |> italics
    |> big
    |> bold
    |> small
    |> output
  end

  def h1(text) do
    Regex.replace(~r/(\n|\r|\r\n|^)\# +([^#][^\n\r]+)/, text, "<h1>\\2</h1>")
  end

  def h2(text) do
    Regex.replace(~r/(\n|\r|\r\n|^)\## +([^##][^\n\r]+)/, text, "<h2>\\2</h2>")
  end

  def italics(text) do
    Regex.replace(~r/\*(.*)\* /, text, "<em>\\1</em>")
  end

  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
  end

  def big(text) do
    Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
  end

  def small(text) do
    Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
  end

  def p(text) do
    Regex.replace(~r/(\n|\r|\r\n|^)+([^#<][^\n\r]+)((\n|\r|\r\n)$)?/, text, "<p>\\2</p>")
  end

  def output(text) do
    File.write!("out.html", text)
  end

  def test_string do
    """
    # Main title
    ## Secondary title

    ++big things++
    --small things--

    I *so* enjoyed eating that burrito, that hot sauce was **amazing**

    What did you think of it?
    """
  end
end
