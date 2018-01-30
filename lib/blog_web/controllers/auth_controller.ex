defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  plug Ueberauth

  def callback(conn, params) do

  end
end
