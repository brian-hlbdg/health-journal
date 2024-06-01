defmodule HealthJournal.Accounts do
  import Ecto.Query, warn: false
  alias HealthJournal.Repo

  alias HealthJournal.Accounts.UserProfile

  def list_user_profiles do
    Repo.all(UserProfile)
  end

  def get_user_profile!(id), do: Repo.get!(UserProfile, id)

  def create_user_profile(attrs \\ %{}) do
    %UserProfile{}
    |> UserProfile.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_profile(%UserProfile{} = user_profile, attrs) do
    user_profile
    |> UserProfile.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_profile(%UserProfile{} = user_profile) do
    Repo.delete(user_profile)
  end

  def change_user_profile(%UserProfile{} = user_profile, attrs \\ %{}) do
    UserProfile.changeset(user_profile, attrs)
  end
end
