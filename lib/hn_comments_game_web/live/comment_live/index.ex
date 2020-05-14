defmodule HnCommentsGameWeb.CommentLive.Index do

  use HnCommentsGameWeb, :live_view
  alias HnCommentsGame.Question
  @interval 1000

  @impl true
  def mount(_params, _session, socket) do
    hn_comment = fetch_hn_comments()
    hn_posts = fetch_hn_posts(hn_comment.post_id)

    {:ok,
     socket
     |> assign(color: nil )
     |> assign(hn_comment: hn_comment, hn_posts: hn_posts)
     |> assign(correct_questions: 0, answered_questions: 0)}
  end

  @impl true
  def handle_info(:update, socket ) do
  {:noreply, socket |> assign(time_left: socket.assigns.time_left + @interval)}
  end

  @impl true
  def handle_event("made_guess", %{"post_id" => post_id}, socket) do
    hn_comment = fetch_hn_comments()
    hn_posts = fetch_hn_posts(hn_comment.post_id)

    is_correct = socket.assigns.hn_comment.post_id == String.to_integer(post_id)

    correct_questions = socket.assigns.correct_questions
    correct_questions = if is_correct, do: correct_questions + 1, else: correct_questions

    answered_questions = socket.assigns.answered_questions + 1

    {:noreply,
     socket
     |> assign(hn_comment: hn_comment, hn_posts: hn_posts)
     |> assign(correct_questions: correct_questions, answered_questions: answered_questions)}
  end

  def handle_event("pick_team", %{"color" => color}, socket) do
    if connected?(socket), do: :timer.send_interval(@interval, self(), :update)
    {:noreply, socket |> assign(color: color, time_left: 0)}
  end

  defp fetch_hn_comments do
    Question.pick_random_hn_comment()
  end

  defp fetch_hn_posts(id) do
    Question.list_hn_posts(id)
  end
end
