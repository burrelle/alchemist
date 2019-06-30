defmodule Friends.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end

  def changeset(person, params \\ %{}) do
    required_fields = [:first_name, :last_name]
    optional_fields = [:age]

    person
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
