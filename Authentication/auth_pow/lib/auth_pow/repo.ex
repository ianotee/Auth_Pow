defmodule AuthPow.Repo do
  use Ecto.Repo,
    otp_app: :auth_pow,
    adapter: Ecto.Adapters.SQLite3
end
