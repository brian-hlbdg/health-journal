defmodule HealthJournal.Repo.Migrations.CreateUserProfiles do
  use Ecto.Migration

  def change do
    create table(:user_profiles) do
      add :user_id, :integer
      add :height, :float
      add :weight, :float
      add :age, :integer
      add :gender, :string
      add :fitness_level, :string
      add :health_conditions, :map
      add :allergies, :map
      add :physical_activity_routine, :string
      add :dietary_preferences, :map
      add :biceps, :float
      add :forearms, :float
      add :calves, :float
      add :stomach, :float
      add :chest, :float
      add :waist, :float
      add :hips, :float
      add :thighs, :float

      timestamps()
    end
  end
end
