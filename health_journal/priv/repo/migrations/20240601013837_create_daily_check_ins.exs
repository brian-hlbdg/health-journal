defmodule HealthJournal.Repo.Migrations.CreateDailyCheckIns do
  use Ecto.Migration

  def change do
    create table(:daily_check_ins) do
      add :user_id, :integer
      add :date, :date
      add :mood, :string

      timestamps()
    end

    create index(:daily_check_ins, [:user_id])
    create unique_index(:daily_check_ins, [:user_id, :date])
  end
end
