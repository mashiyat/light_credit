defmodule LightCredit.Repo do
  use Ecto.Repo,
    otp_app: :light_credit,
    adapter: Ecto.Adapters.Postgres
end
