defmodule AlchemyMarkdown do
  def to_html(markdown) do
    markdown
    |> hrs
    |> earmark
    |> big
    |> small
  end

  def earmark(text) do
    Earmark.as_html!(text || "", %Earmark.Options{smartypants: false})
  end

  def big(text) do
    Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
  end

  def small(text) do
    Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
  end

  def hrs(text) do
    Regex.replace(~r{(\r\n|\r|\n)([-*])( *\2 *)+\2}, text, "\\1<hr />")
  end
end
