defmodule HealthJournalWeb.CheckInLive do
  use Phoenix.LiveView
  alias HealthJournal.CheckIns
  alias HealthJournal.CheckIns.DailyCheckIn

  def mount(_params, _session, socket) do
    {:ok, assign(socket, check_in: %DailyCheckIn{})}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto p-6 bg-white shadow-md rounded-md">
      <h1 class="text-2xl font-semibold mb-4">Daily Mood Check-In</h1>
      <form phx-submit="save_check_in" class="space-y-4">
        <div>
          <label for="date" class="block text-sm font-medium text-gray-700">Date:</label>
          <input type="date" name="check_in[date]" id="date" value={@check_in.date} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="mood" class="block text-sm font-medium text-gray-700">Mood:</label>
          <select name="check_in[mood]" id="mood" value={@check_in.mood} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            <option value="happy">Happy</option>
            <option value="sad">Sad</option>
            <option value="anxious">Anxious</option>
            <option value="stressed">Stressed</option>
            <option value="calm">Calm</option>
          </select>
        </div>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md shadow-sm hover:bg-blue-700">Submit</button>
      </form>
    </div>
    """
  end

  def handle_event("save_check_in", %{"check_in" => check_in_params}, socket) do
    case CheckIns.create_daily_check_in(check_in_params) do
      {:ok, check_in} ->
        {:noreply, assign(socket, check_in: check_in)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
