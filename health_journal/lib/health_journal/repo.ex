defmodule HealthJournal.Repo do
  use Ecto.Repo,
    otp_app: :health_journal,
    adapter: Ecto.Adapters.Postgres
end
