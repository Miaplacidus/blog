defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers
  alias BlogWeb.AuthController

  def admin_signin(conn, _params) do 
    render(conn, "new.html")
  end
  
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    %Ueberauth.Auth{ extra: %Ueberauth.Auth.Extra{ raw_info: %{ user: %{ "email" => email} }}, uid: uid} = auth

    author = Blog.Accounts.find_author(email)

    case author do 
      %Blog.Accounts.Author{} -> 
        AuthController.login({:ok, author})

      nil ->
        AuthController.login({:error, "Naaah, son!"})
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> redirect(to: "/")
  end

  defp login({:ok, author}, conn) do 
    conn
    |> BlogWeb.Guardian.Plug.sign_in(author)
    |> redirect(to: post_path(conn, :new))
  end

  defp login({:error, _}, conn) do 
    conn
    |> redirect(to: "/")
  end
end
