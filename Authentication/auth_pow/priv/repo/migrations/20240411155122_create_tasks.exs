defmodule AuthPow.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :complete, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
