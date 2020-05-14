defmodule HnCommentsGame.Question do
  @moduledoc """
  The Question context.
  """

  import Ecto.Query, warn: false
  alias HnCommentsGame.Repo

  alias HnCommentsGame.Question.Comment
  alias HnCommentsGame.Question.Post
  alias HnCommentsGame.Question.Team

  def list_teams do
    Repo.all(from t in Team, order_by: [desc: t.color])
  end

  @doc """
  Returns a randomly stored hn_comment.

  ## Examples

      iex> pick_random_hn_comment()
      %Comment{}

  """
  def pick_random_hn_comment do
    query =
      from Comment,
        order_by: fragment("RANDOM()"),
        limit: 1

    Repo.one(query)
  end

  @doc """
  Returns 4 randomly stored hn_posts.

  ## Examples

      iex> random_hn_posts()
      [%Post{},...]

  """
  def random_hn_posts do
    query =
      from Post,
        order_by: fragment("RANDOM()"),
        limit: 4

    Repo.all(query)
  end

  @doc """
  Gets posts including `id`.

  Raises `Ecto.NoResultsError` if the Post with id `id` does not exist.
  """
  def list_hn_posts(id) do
    [get_post!(id) | random_hn_posts()] |> Enum.shuffle() |> Enum.uniq()
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def update_score(%Team{color: color, correct_questions: correct, time_taken: time_taken}) do
    from(t in Team, where: t.color == ^color, select: t)
    |> Repo.update_all(
      inc: [answered_questions: 5, correct_questions: correct, time_taken: time_taken]
    )
  end
end
