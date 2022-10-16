defmodule MarkdownPageGenerator.Github do
  @moduledoc """
    Module used for fetching the data from github, the markdown files that would be transcribed into html.
    Requires to set up three env variables:
    - GITHUB_USER
    - GITHUB_PROJECT
    - GITHUB_BRANCH

    MarkdownPageGenerator.Github.fetch/1 function needs only the relative path to file, ie. "README.md" or "config/rules.md"
  """

  @base "https://raw.githubusercontent.com"
  def fetch(file_route) do
    final_route = "#{@base}/#{specific_route()}/#{file_route}"

    {:ok, %{body: body}} = HTTPoison.get(final_route)

    body
  end

  defp specific_route do
    user = Application.get_env(:markdown_page_generator, :user)
    project = Application.get_env(:markdown_page_generator, :project)
    branch = Application.get_env(:markdown_page_generator, :branch)

    unless user, do: raise "missing env variable - GITHUB_USER"
    unless project, do: raise "missing env variable - GITHUB_PROJECT"
    unless branch, do: raise "missing env variable - GITHUB_BRANCH"

    "#{user}/#{project}/#{branch}"
  end
end
