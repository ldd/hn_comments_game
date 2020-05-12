defmodule HnCommentsGame.Scrapper.Repo do
  alias HnCommentsGame.Repo
  alias HnCommentsGame.Question.Comment
  alias HnCommentsGame.Question.Post

  def db_upload(comments) do
    Enum.each(comments, fn
      %{post_id: post_id, post_title: post_title, text: comment_text, id: comment_id} ->
        add_post(post_id, post_title)
        add_comment(comment_id, comment_text, post_id)

      _ ->
        nil
    end)
  end

  def add_post(id, title) do
    case Repo.get(Post, id) do
      # Post not found, we build one
      nil -> %Post{id: id, title: title}
      # Post exists, let's use it
      post -> post
    end
    |> Post.changeset(%{title: title})
    |> Repo.insert_or_update()
  end

  def add_comment(id, text, post_id) do
    case Repo.get(Comment, id) do
      # Post not found, we build one
      nil -> %Comment{id: id, text: text, post_id: post_id}
      # Post exists, let's use it
      post -> post
    end
    |> Comment.changeset(%{text: text, post_id: post_id})
    |> Repo.insert_or_update()
  end
end
