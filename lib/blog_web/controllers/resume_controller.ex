defmodule BlogWeb.ResumeController do
  use BlogWeb, :controller

  def download_resume(conn, _params) do
    path = Path.join(:code.priv_dir(:blog), "/static/documents/IAniemeka_Resume.pdf")
    conn
      |> put_resp_content_type("application/pdf", "utf-8")
      |> send_file(200, path)
  end
end
