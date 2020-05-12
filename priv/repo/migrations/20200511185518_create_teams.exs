defmodule HnCommentsGame.Repo.Migrations.AddTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :color, :string
      add :score, :integer

      timestamps()
    end

    create unique_index(:teams, [:color])
  end
end
