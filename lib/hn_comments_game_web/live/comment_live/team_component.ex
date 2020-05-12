defmodule HnCommentsGameWeb.CommentLive.TeamComponent do
  use HnCommentsGameWeb, :live_component
  alias HnCommentsGame.Question

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{color: color, correct_questions: correct_questions}, socket)
      when not is_nil(color) do
    Question.update_score(color, correct_questions)
    {:ok, assign(socket, color: color, teams: Question.list_teams())}
  end

  def update(%{color: color}, socket) do
    {:ok, assign(socket, color: color, teams: Question.list_teams())}
  end
end
