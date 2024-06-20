defmodule HealthJournalWeb.CheckInLive do
  use Phoenix.LiveView
  alias HealthJournal.CheckIns
  alias HealthJournal.CheckIns.DailyCheckIn

  def mount(_params, _session, socket) do
    {:ok, assign(socket, check_in: %DailyCheckIn{})}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Daily Mood Check-In</h1>
      <form phx-submit="save_check_in">
        <div>
          <label for="mood">Mood:</label>
          <select name="check_in[mood]" id="mood" value={@check_in.mood}>
            <option value="happy">Happy</option>
            <option value="sad">Sad</option>
            <option value="anxious">Anxious</option>
            <option value="stressed">Stressed</option>
            <option value="calm">Calm</option>
          </select>
        </div>
        <button type="submit">Submit</button>
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
