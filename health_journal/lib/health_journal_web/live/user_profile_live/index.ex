defmodule HealthJournalWeb.UserProfileLive.Index do
  use HealthJournalWeb, :live_view
  import Phoenix.HTML

  alias HealthJournal.Accounts
  alias HealthJournal.Accounts.UserProfile

  def mount(_params, _session, socket) do
    {:ok, assign(socket, profiles: list_profiles())}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    profile = Accounts.get_user_profile!(id)
    {:ok, _} = Accounts.delete_user_profile(profile)

    {:noreply, assign(socket, profiles: list_profiles())}
  end

  defp list_profiles do
    Accounts.list_user_profiles()
  end
end
