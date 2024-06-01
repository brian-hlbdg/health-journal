defmodule HealthJournal.CheckIns.DailyCheckIn do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_check_ins" do
    field :user_id, :integer
    field :date, :date
    field :mood, :string

    timestamps()
  end

  @doc false
  def changeset(daily_check_in, attrs) do
    daily_check_in
    |> cast(attrs, [:user_id, :date, :mood])
    |> validate_required([:user_id, :date, :mood])
  end
end
