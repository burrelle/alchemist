defmodule Friends.PersonTest do
  use ExUnit.Case
  import Friends
  import Friends.TestHelpers

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Friends.Repo)
  end

  test "default person can be created" do
    %{first_name: first_name, last_name: last_name, age: age} = person_fixture()
    assert first_name == "first"
    assert last_name == "last"
    assert age in 1..100 == true
  end

  test "first_name can be added to fixture" do
    changed_name = "Changed"
    %{first_name: expected_first_name} = person_fixture([first_name: changed_name])
    assert expected_first_name == changed_name
  end

  test "last_name can be added to fixture" do
    changed_name = "Changed"
    %{last_name: expected_last_name} = person_fixture([last_name: changed_name])
    assert expected_last_name == changed_name
  end

  test "age can be added to fixture" do
    changed_age = 42
    %{age: expected_age} = person_fixture([age: changed_age])
    assert expected_age == changed_age
  end

  test "find_by_first_name returns the correct record" do
    greg = person_fixture(%{first_name: "Greg"})
    greg_ecto_record = find_by_first_name(greg.first_name)
    assert greg_ecto_record.first_name == greg.first_name
  end

  test "find_by_first_name returns nothing with name not found" do
    person_fixture()
    failure_record = find_by_first_name("Not the default name")
    assert failure_record == nil
  end
end
