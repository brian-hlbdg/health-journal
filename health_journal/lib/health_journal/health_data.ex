defmodule HealthJournal.HealthData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "health_data" do
    field :user_id, :integer
    field :date, :date
    field :steps, :integer
    field :heart_rate, :integer
    field :calories_burned, :integer

    timestamps()
  end

  @doc false
  def changeset(health_data, attrs) do
    health_data
    |> cast(attrs, [:user_id, :date, :steps, :heart_rate, :calories_burned])
    |> validate_required([:user_id, :date, :steps, :heart_rate, :calories_burned])
  end
end
