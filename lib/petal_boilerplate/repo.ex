defmodule OverStats.Repo do
  use Ecto.Repo,
    otp_app: :overstats,
    adapter: Ecto.Adapters.MyXQL
end
