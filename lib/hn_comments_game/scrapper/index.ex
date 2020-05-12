defmodule HnCommentsGame.Scrapper do
  alias HnCommentsGame.Scrapper.Fetcher
  alias HnCommentsGame.Scrapper.Repo

  def update do
    Fetcher.fetch_posts() |> Repo.db_upload()
  end
end
