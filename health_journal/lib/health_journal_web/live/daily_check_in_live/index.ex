defmodule HealthJournalWeb.DailyCheckInLive.Index do
  use HealthJournalWeb, :live_view
  alias HealthJournal.CheckIns
  alias HealthJournal.CheckIns.DailyCheckIn

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :daily_check_ins, list_daily_check_ins())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily Check-In")
    |> assign(:daily_check_in, CheckIns.get_daily_check_in!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily Check-In")
    |> assign(:daily_check_in, %DailyCheckIn{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily Check-Ins")
    |> assign(:daily_check_in, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_check_in = CheckIns.get_daily_check_in!(id)
    {:ok, _} = CheckIns.delete_daily_check_in(daily_check_in)

    {:noreply, assign(socket, :daily_check_ins, list_daily_check_ins())}
  end

  defp list_daily_check_ins do
    CheckIns.list_daily_check_ins()
  end
end
