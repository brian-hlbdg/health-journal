defmodule HealthJournal.CheckIns do
  import Ecto.Query, warn: false
  alias HealthJournal.Repo

  alias HealthJournal.CheckIns.DailyCheckIn

  def list_daily_check_ins do
    Repo.all(DailyCheckIn)
  end

  def get_daily_check_in!(id), do: Repo.get!(DailyCheckIn, id)

  def create_daily_check_in(attrs \\ %{}) do
    %DailyCheckIn{}
    |> DailyCheckIn.changeset(attrs)
    |> Repo.insert()
  end

  def update_daily_check_in(%DailyCheckIn{} = daily_check_in, attrs) do
    daily_check_in
    |> DailyCheckIn.changeset(attrs)
    |> Repo.update()
  end

  def delete_daily_check_in(%DailyCheckIn{} = daily_check_in) do
    Repo.delete(daily_check_in)
  end

  def change_daily_check_in(%DailyCheckIn{} = daily_check_in, attrs \\ %{}) do
    DailyCheckIn.changeset(daily_check_in, attrs)
  end
end
