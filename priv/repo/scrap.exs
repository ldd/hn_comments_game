#     mix run priv/repo/scrap.exs
alias HnCommentsGame.Repo
alias HnCommentsGame.Scrapper

Repo.transaction(fn ->
  Repo.query("TRUNCATE hn_comments", [])
  Repo.query("TRUNCATE hn_posts", [])

  Scrapper.update()
end)
