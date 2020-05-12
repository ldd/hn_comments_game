defmodule HnCommentsGame.Repo do
  use Ecto.Repo,
    otp_app: :hn_comments_game,
    adapter: Ecto.Adapters.Postgres
end
