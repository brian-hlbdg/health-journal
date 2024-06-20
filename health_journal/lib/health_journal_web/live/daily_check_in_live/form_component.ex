defmodule HealthJournalWeb.DailyCheckInLive.FormComponent do
  use HealthJournalWeb, :live_component

  alias HealthJournal.CheckIns

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage daily_check_in records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="daily_check_in-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Daily check in</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{daily_check_in: daily_check_in} = assigns, socket) do
    changeset = CheckIns.change_daily_check_in(daily_check_in)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"daily_check_in" => daily_check_in_params}, socket) do
    changeset =
      socket.assigns.daily_check_in
      |> CheckIns.change_daily_check_in(daily_check_in_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_check_in" => daily_check_in_params}, socket) do
    save_daily_check_in(socket, socket.assigns.action, daily_check_in_params)
  end

  defp save_daily_check_in(socket, :edit, daily_check_in_params) do
    case CheckIns.update_daily_check_in(socket.assigns.daily_check_in, daily_check_in_params) do
      {:ok, daily_check_in} ->
        notify_parent({:saved, daily_check_in})

        {:noreply,
         socket
         |> put_flash(:info, "Daily check in updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_daily_check_in(socket, :new, daily_check_in_params) do
    case CheckIns.create_daily_check_in(daily_check_in_params) do
      {:ok, daily_check_in} ->
        notify_parent({:saved, daily_check_in})

        {:noreply,
         socket
         |> put_flash(:info, "Daily check in created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
