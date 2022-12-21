defmodule Overstats.Repo do
  use Ecto.Repo,
    otp_app: :overstats,
    adapter: Ecto.Adapters.Postgres
end
