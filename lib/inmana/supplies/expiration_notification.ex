defmodule Inmana.Supplies.ExpirationNotification do
  alias Inmana.Mailer
  alias Inmana.Supplies.GetByExpiration

  def send do
    data = GetByExpiration.call()

    Enum.each(data, n {to_email, supplies} ->

    end)
  end
end
