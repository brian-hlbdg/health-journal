defmodule HealthJournal.Accounts.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_profiles" do
    field :user_id, :integer
    field :height, :float
    field :weight, :float
    field :bmi, :float, virtual: true
    field :tdee, :float, virtual: true
    field :age, :integer
    field :gender, :string
    field :fitness_level, :string
    field :health_conditions, :map
    field :allergies, :map
    field :physical_activity_routine, :string
    field :dietary_preferences, :map

    # Additional physical measurements
    field :biceps, :float
    field :forearms, :float
    field :calves, :float
    field :stomach, :float
    field :chest, :float
    field :waist, :float
    field :hips, :float
    field :thighs, :float

    timestamps()
  end

  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [
        :user_id, :height, :weight, :age, :gender, :fitness_level,
        :health_conditions, :allergies, :physical_activity_routine,
        :dietary_preferences, :biceps, :forearms, :calves,
        :stomach, :chest, :waist, :hips, :thighs
      ])
    |> validate_required([:user_id, :height, :weight, :age, :gender, :fitness_level])
    |> compute_bmi_and_tdee()
  end

  defp compute_bmi_and_tdee(changeset) do
    height = get_field(changeset, :height)
    weight = get_field(changeset, :weight)
    age = get_field(changeset, :age)
    gender = get_field(changeset, :gender)
    fitness_level = get_field(changeset, :fitness_level)

    bmi = if height && weight, do: weight / (height * height), else: nil
    tdee = if bmi && age && gender && fitness_level do
      bmr = case gender do
        "male" -> 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
        "female" -> 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
      end
      multiplier = case fitness_level do
        "sedentary" -> 1.2
        "lightly active" -> 1.375
        "moderately active" -> 1.55
        "very active" -> 1.725
        "super active" -> 1.9
      end
      bmr * multiplier
    else
      nil
    end

    changeset
    |> put_change(:bmi, bmi)
    |> put_change(:tdee, tdee)
  end
end
