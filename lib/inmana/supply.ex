defmodule Inmana.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Restaurant

  # module variable, maybe aka private variable
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:description, :expiration_date, :responsible, :restaurant_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "supplies" do
    field :description, :string
    field :expiration_date, :date
    field :responsible, :string

    belongs_to :restaurant, Restaurant

    timestamps()
  end

  # Changeset is responsible for receiving the data, cast it and validatate
  # also, thru the changeset, the data is inserted in the DB
  # The changeset starts as a struct (like a empty map)
  # For example, this is a map: %{} and this is a struct:
  # %Inmana.Supply{}
  def changeset(params) do
    # %__MODULE__{} === %Inmana.Supply{}
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 3)
    |> validate_length(:responsible, min: 3)
  end
end
