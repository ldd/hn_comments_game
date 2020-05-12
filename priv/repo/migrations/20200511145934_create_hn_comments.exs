defmodule HnCommentsGame.Repo.Migrations.CreateHnComments do
  use Ecto.Migration

  def change do
    create table(:hn_comments) do
      add :text, :text
      add :post_id, :integer

      timestamps()
    end

    create table(:hn_posts) do
      add :title, :string

      timestamps()
    end
  end
end
