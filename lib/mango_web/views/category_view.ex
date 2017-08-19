defmodule MangoWeb.CategoryView do
  use MangoWeb, :view

  def title_case(name) do
    name
    |> String.downcase
    |> String.capitalize
  end
end
