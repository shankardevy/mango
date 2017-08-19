defmodule MangoWeb.Acceptance.SessionTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    # There is a valid registered user
    alias Mango.CRM
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    {:ok, _} = CRM.create_customer(valid_attrs)
    :ok
  end

  test "successful login for valid credential" do
    ## When ##
    navigate_to("/login")

    form = find_element(:id, "session-form")
    find_within_element(form, :name, "session[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "session[password]")
    |> fill_field("secret")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    assert current_path() == "/"
    message = find_element(:class, "alert-info")
              |> visible_text()

    assert message == "Login successful"
  end

  test "shows error message for invalid credentials" do
    ## WHEN ##
    navigate_to("/login")

    form = find_element(:id, "session-form")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    assert current_path() == "/login"
    message = find_element(:class, "alert-danger") |> visible_text()
    assert message == "Invalid username/password combination"
  end
end
