defmodule HnCommentsGame.Scrapper.Fetcher do
  @url "https://hacker-news.firebaseio.com/v0/"
  @n_top_posts 20
  @n_top_comments 5

  # HnGame.Fetcher.fetch_posts() |> Enum.group_by(& &1[:post_id])

  def fetch_posts do
    case fetch("#{@url}topstories.json") do
      {:ok, [_head | _tail] = post_Ids} ->
        post_Ids
        |> Enum.take(@n_top_posts)
        |> Enum.flat_map(fn post_id ->
          case fetch_post(post_id) do
            {title, comments} ->
              comments
              |> Enum.take(@n_top_comments)
              |> Enum.map(fn comment_id ->
                %{
                  post_id: post_id,
                  post_title: title,
                  text: fetch_comment(comment_id),
                  id: comment_id
                }
              end)

            _ ->
              []
          end
        end)

      _ ->
        nil
    end
  end

  def fetch_post(post_id) do
    case fetch("#{@url}item/#{post_id}.json") do
      {:ok, %{"title" => title, "kids" => kids}} -> {title, kids}
      _ -> nil
    end
  end

  def fetch_comment(item_id) do
    case fetch("#{@url}item/#{item_id}.json") do
      {:ok, %{"text" => text}} -> text
      _ -> nil
    end
  end

  defp fetch(url) do
    case Elixir.HTTPoison.get!(url) do
      %Elixir.HTTPoison.Response{status_code: 200, body: body} ->
        Jason.decode(body)
    end
  end
end
