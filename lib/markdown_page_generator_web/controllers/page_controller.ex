defmodule MarkdownPageGeneratorWeb.PageController do
  use MarkdownPageGeneratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
