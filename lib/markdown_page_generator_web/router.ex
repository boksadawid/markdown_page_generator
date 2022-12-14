defmodule MarkdownPageGeneratorWeb.Router do
  use MarkdownPageGeneratorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MarkdownPageGeneratorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarkdownPageGeneratorWeb do
    pipe_through :browser

    get "/", PageController, :show
    get "/:route", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", MarkdownPageGeneratorWeb do
  #   pipe_through :api
  # end
end
