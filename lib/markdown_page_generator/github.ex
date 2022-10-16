defmodule MarkdownPageGenerator.Github do
  @moduledoc """
    Module used for fetching the data from github, the markdown files that would be transcribed into html.
    Requires to set up two env variables:
    - GITHUB_USER
    - GITHUB_PROJECT

    Optional env variables are:
    - GITHUB_BRANCH
    - GITHUB_AUTH_TOKEN

    MarkdownPageGenerator.Github.fetch/1 function needs only the relative path to file, ie. "README.md" or "config/rules.md"
  """

  @base "https://api.github.com/repos"
  def fetch(file_route) do
    final_route = "#{@base}/#{specific_route()}/#{file_route}#{maybe_add_branch()}"

    {:ok, %{body: body}} = HTTPoison.get(final_route, headers())

    body
  end

  defp specific_route do
    user = Application.get_env(:markdown_page_generator, :user)
    project = Application.get_env(:markdown_page_generator, :project)

    unless user, do: raise "missing env variable - GITHUB_USER"
    unless project, do: raise "missing env variable - GITHUB_PROJECT"

    "#{user}/#{project}/contents"
  end

  defp maybe_add_branch do
    branch = Application.get_env(:markdown_page_generator, :branch)

    if branch do
      "?ref=#{branch}"
    else
      ""
    end
  end

  defp headers do
    auth_token = Application.get_env(:markdown_page_generator, :auth_token)

    if auth_token do
      [
        "Authorization": "token #{auth_token}",
        "Accept": "application/vnd.github.v3.raw"
      ]
    else
      [
        "Accept": "application/vnd.github.v3.raw"
      ]
    end
  end
end
