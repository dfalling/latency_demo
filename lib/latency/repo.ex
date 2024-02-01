defmodule Latency.Repo do
  use Ecto.Repo,
    otp_app: :latency,
    adapter: Ecto.Adapters.Postgres
end
