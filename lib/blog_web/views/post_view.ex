defmodule BlogWeb.PostView do
  use BlogWeb, :view

  def to_markdown(body) do 
    body
    |> Earmark.as_html
    |> elem(1)
    |> raw
  end
end
