defmodule Friends.TestHelpers do
  alias Friends.Repo
  alias Friends.Person

  def person_fixture(attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        first_name: attrs[:first_name] || "first",
        last_name: attrs[:last_name] || "last",
        age: attrs[:age] || Enum.random(1..100)
      })

    {:ok, person} =
      %Friends.Person{}
      |> Person.changeset(attrs)
      |> Repo.insert()

    person
  end
end
