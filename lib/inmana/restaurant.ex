defmodule Inmana.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  # module variable, maybe aka private variable
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :name]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "restaurants" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  # Changeset is responsible for receiving the data, cast it and validatate
  # also, thru the changeset, the data is inserted in the DB
  # The changeset starts as a struct (like a empty map)
  # For example, this is a map: %{} and this is a struct:
  # %Inmana.Restaurant{}
  def changeset(params) do
    # %__MODULE__{} === %Inmana.Restaurant{}
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
