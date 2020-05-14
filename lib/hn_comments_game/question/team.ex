defmodule HnCommentsGame.Question.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :color, :string
    field :correct_questions, :integer, default: 0
    field :answered_questions, :integer, default: 0
    field :time_taken, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:color])
    |> validate_required([:color])
    |> unique_constraint(:color)
  end
end
