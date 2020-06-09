defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers

  def admin_signin(conn, _params) do
    render(conn, "new.html")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    %Ueberauth.Auth{ info: %Ueberauth.Auth.Info{ email: email}} = auth
    author = Blog.Accounts.find_author(email)

    case Blog.Accounts.find_author(email) do
      author ->
        login({:ok, author}, conn)

      nil ->
        login({:error, "Naaah, son!"}, conn)
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> redirect(to: "/")
  end

  defp login({:ok, author}, conn) do
    conn
    |> Blog.Guardian.Plug.sign_in(author)
    |> redirect(to: Routes.post_path(conn, :new))
  end

  defp login({:error, _}, conn) do
    conn
    |> redirect(to: "/")
  end
end
