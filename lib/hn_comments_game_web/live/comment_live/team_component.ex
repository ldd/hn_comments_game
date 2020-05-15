defmodule HnCommentsGameWeb.CommentLive.TeamComponent do
  use HnCommentsGameWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{team: team, teams: teams}, socket) do
    {:ok, assign(socket, team: team, teams: teams)}
  end
end
