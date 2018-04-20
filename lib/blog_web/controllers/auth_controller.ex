defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  plug Ueberauth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def callback(conn, params) do

  end
end
