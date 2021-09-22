defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email
  alias Inmana.Supply

  def create(to_email, supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com.br",
      subject: "Supplies that are expiring soon",
      text_body: email_text(supplies)
    )
  end

  defp email_text(supplies) do
    initial_text = "--------- Supplies that are expiring soon ---------\n"
    # reduce([1,2,3,4,5], acc_initial_value, fn elem, acc -> acc + elm end)
    Enum.reduce(supplies, initial_text, fn supply, text -> text <> supply_string(supply) end)
  end

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }) do
    "Description: #{description}, Expiration date: #{expiration_date}, Responsible: #{responsible}\n"
  end
end
