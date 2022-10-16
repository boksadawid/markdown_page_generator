defmodule MarkdownPageGeneratorWeb.PageView do
  use MarkdownPageGeneratorWeb, :view

  def parse_data(data) do
    Earmark.as_html!(data)
  end
end
