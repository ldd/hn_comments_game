defmodule HnCommentsGame.Repo.Migrations.AlterTeamDuration do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      # time taken in milliseconds
      add :time_taken, :integer, default: 0
    end
  end
end
