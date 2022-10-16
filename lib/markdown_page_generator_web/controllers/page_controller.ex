defmodule MarkdownPageGeneratorWeb.PageController do
  use MarkdownPageGeneratorWeb, :controller

  alias MarkdownPageGenerator.Github

  def show(conn, %{"route" => route}) do
    data = Github.fetch(route)

    render(conn, "show.html", data: data)
  end

  def show(conn, _), do: show(conn, %{"route" => "README.md"})
end
