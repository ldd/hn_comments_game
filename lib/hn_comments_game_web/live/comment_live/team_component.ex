defmodule HnCommentsGameWeb.CommentLive.TeamComponent do
  use HnCommentsGameWeb, :live_component
  alias HnCommentsGame.Question

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{team: %Question.Team{color: color} = team}, socket)
      when not is_nil(color) do
    Question.update_score(team)
    {:ok, assign(socket, team: team, teams: Question.list_teams())}
  end

  def update(%{team: nil}, socket) do
    {:ok, assign(socket, team: nil, teams: Question.list_teams())}
  end
end
