defmodule HealthJournalWeb.UserProfileLive.Show do
  use HealthJournalWeb, :live_view
  alias HealthJournal.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply, assign(socket, :user_profile, Accounts.get_user_profile!(id))}
  end
end
