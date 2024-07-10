defmodule HealthJournalWeb.HealthDataController do
  use HealthJournalWeb, :controller
  alias HealthJournal.Accounts
  alias HealthJournal.CheckIns

  def create(conn, %{"health_data" => health_data_params}) do
    case process_health_data(health_data_params) do
      {:ok, _result} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Health data received successfully"})

      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Failed to process health data"})
    end
  end

  defp process_health_data(params) do
    # Implement the logic to process and store health data
    # For example, you could extract different types of health data and store them in different tables
    # This is a simplified example assuming the data is stored in a single table

    %{
      "user_id" => user_id,
      "date" => date,
      "steps" => steps,
      "heart_rate" => heart_rate,
      "calories_burned" => calories_burned
    } = params

    # Assuming we have a HealthData schema to store the received data
    %HealthJournal.HealthData{}
    |> HealthJournal.HealthData.changeset(%{
      user_id: user_id,
      date: date,
      steps: steps,
      heart_rate: heart_rate,
      calories_burned: calories_burned
    })
    |> HealthJournal.Repo.insert()
  end
end
