defmodule HnCommentsGame.Repo.Migrations.AlterTeamTableScore do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :correct_questions, :integer, default: 0
      add :answered_questions, :integer, default: 0
      remove_if_exists :score, :integer
    end
  end
end
