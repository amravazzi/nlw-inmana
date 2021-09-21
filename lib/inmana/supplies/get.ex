defmodule Inmana.Supplies.Get do
  alias Inmana.{Repo, Supply}

  # def call(uuid) do
  #   Supply
  #   |> Repo.get(uuid)
  #   |> handle_insert()
  # end

  # defp handle_insert(%Supply{} = result), do: {:ok, result}
  # defp handle_insert(nil), do: {:error, %{result: "Supply not found.", status: :not_found}}

  def call(uuid) do
    case Repo.get(Supply, uuid) do
      nil -> {:error, %{result: "Supply not found.", status: :not_found}}
      supply -> {:ok, supply}
    end
  end


end
