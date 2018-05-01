defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Content

  def index(conn, _params) do
    render(conn, "index.html", posts: Content.list_posts(4))
  end
end
