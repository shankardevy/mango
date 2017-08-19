defmodule MangoWeb.Acceptance.RegistrationTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  test "registers an account with valid data" do
    navigate_to("/register")

    form = find_element(:id, "registration-form")
    find_within_element(form, :name, "registration[name]")
    |> fill_field("John")

    find_within_element(form, :name, "registration[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "registration[phone]")
    |> fill_field("1111")

    find_element(:css, "#registration_residence_area option[value='Area 1']") |> click

    find_within_element(form, :name, "registration[password]")
    |> fill_field("password")

    find_within_element(form, :tag, "button")
    |> click

    assert current_path() == "/"
    message = find_element(:class, "alert")
              |> visible_text()

    assert message == "Registration successful"
  end

  test "shows error messages on invalid data" do
    navigate_to("/register")

    form = find_element(:id, "registration-form")
    find_within_element(form, :tag, "button") |> click

    assert current_path() == "/register"
    message = find_element(:id, "form-error") |> visible_text()
    assert message == "Oops, something went wrong! Please check the errors below."
  end

end
