defmodule HnCommentsGame.Question.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hn_posts" do
    field :title, :string
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
