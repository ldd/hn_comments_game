defmodule HnCommentsGameWeb.CommentLive.Index do
  use HnCommentsGameWeb, :live_view
  alias HnCommentsGame.Question
  @interval 1000

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Question.subscribe()
    hn_comment = fetch_hn_comments()
    hn_posts = fetch_hn_posts(hn_comment.post_id)

    {:ok,
     socket
     |> assign(team: nil, teams: Question.list_teams())
     |> assign(hn_comment: hn_comment, hn_posts: hn_posts)}
  end

  @impl true
  def handle_info(:update, socket) do
    if socket.assigns.team.answered_questions >= 5 do
      {:noreply, socket}
    else
      {:noreply,
       socket |> assign(team: Map.update(socket.assigns.team, :time_taken, 0, &(&1 + @interval)))}
    end
  end

  def handle_info(:team_stats_updated, socket) do
    if not is_nil(socket.assigns.team) and socket.assigns.team.answered_questions >= 5 do
      {:noreply, socket |> assign(teams: Question.list_teams())}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("made_guess", %{"post_id" => post_id}, socket) do
    hn_comment = fetch_hn_comments()
    hn_posts = fetch_hn_posts(hn_comment.post_id)

    is_correct = socket.assigns.hn_comment.post_id == String.to_integer(post_id)

    team =
      if is_correct and not is_nil(socket.assigns.team) do
        Map.update(socket.assigns.team, :correct_questions, 0, &(&1 + 1))
      else
        socket.assigns.team
      end

    team = Map.update(team, :answered_questions, 0, &(&1 + 1))

    teams =
      if team.answered_questions >= 5 do
        Question.update_score(team)
        Question.list_teams()
      else
        socket.assigns.teams
      end

    {:noreply,
     socket
     |> assign(hn_comment: hn_comment, hn_posts: hn_posts)
     |> assign(team: team, teams: teams)}
  end

  def handle_event("pick_team", %{"color" => color}, socket) do
    if connected?(socket), do: :timer.send_interval(@interval, self(), :update)
    {:noreply, socket |> assign(team: %Question.Team{color: color})}
  end

  defp fetch_hn_comments do
    Question.pick_random_hn_comment()
  end

  defp fetch_hn_posts(id) do
    Question.list_hn_posts(id)
  end
end
