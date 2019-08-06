defmodule BlogWeb.DocumentController do
  use BlogWeb, :controller

  def download_resume(conn, _params) do
    path = Path.join(:code.priv_dir(:blog), "/static/documents/IAniemeka_Resume.pdf")
    conn
      |> put_resp_content_type("application/pdf", "utf-8")
      |> send_file(200, path)
  end

  def download_physnet_paper(conn, _params) do
    path = Path.join(:code.priv_dir(:blog), "/static/documents/intuitive_physics_net_paper.pdf")
    conn
      |> put_resp_content_type("application/pdf", "utf-8")
      |> send_file(200, path)
  end
end
