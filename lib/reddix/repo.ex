defmodule Reddix.Repo do
  use Ecto.Repo,
    otp_app: :reddix,
    adapter: Ecto.Adapters.Postgres
end
