defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  plug Ueberauth
  alias Uberauth.Strategy.Helpers

  def new(conn, _params) do 
    render(conn, "new.html")
  end
  
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    conn
    |> put_flash(:info, "coooool beans")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end
end
