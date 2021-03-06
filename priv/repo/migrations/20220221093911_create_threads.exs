defmodule Reddix.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :text, null: false

      timestamps()
    end
  end
end
