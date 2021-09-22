defmodule Inmana.Restaurant do
  # The `use` macro allows you to inject any code in the current module.
  use Ecto.Schema
  # imports all public functions and macros from given module except the ones starting with underscore, for example, __build__.
  import Ecto.Changeset
  # `alias/2` gives module an alternative name and `alias/1` just the sufix
  alias Inmana.Supply

  # module variable, maybe aka private variable
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :name]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "restaurants" do
    field :email, :string
    field :name, :string

    has_many :supplies, Supply

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
