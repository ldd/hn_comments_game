defmodule HnCommentsGame.Question.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hn_comments" do
    field :post_id, :integer
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :post_id])
    |> validate_required([:text, :post_id])
  end
end
