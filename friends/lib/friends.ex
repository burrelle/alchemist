defmodule Friends do
  alias Friends.Repo
  alias Friends.Person

  def find_by_first_name(first_name) do
    Repo.get_by(Person, first_name: first_name)
  end
end
