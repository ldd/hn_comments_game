# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HnCommentsGame.Repo.insert!(%HnCommentsGame.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias HnCommentsGame.Question
alias HnCommentsGame.Repo
alias HnCommentsGame.Scrapper


Repo.transaction(fn ->
  Repo.query("TRUNCATE hn_comments", [])
  Repo.query("TRUNCATE hn_posts", [])
  Repo.query("TRUNCATE teams", [])

  Repo.insert!(%Question.Team{color: "red"})
  Repo.insert!(%Question.Team{color: "blue"})
  Repo.insert!(%Question.Team{color: "green"})

  Scrapper.update()
end)
