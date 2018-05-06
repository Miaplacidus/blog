use Timex

defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def to_html(body) do 
    tmp_dir_path = Path.join(System.tmp_dir, "post_body.md")
    File.write(tmp_dir_path, body)
    
    args = [tmp_dir_path, "--from", "markdown", "--to", "html"]

    {output, _} = System.cmd "pandoc", args
    output
  end

  def safe_html(body) do 
    PostView.to_html(body)
    |> raw
  end

  def display_time(time) do
    {_status, humanized_time } = Timex.format(time, "%A %B %e, %Y", :strftime)
    humanized_time
  end

  def render("preview.json", %{post_body: post_body}) do
    %{ data: %{ post_body: PostView.to_html(post_body) }}
  end

  def generate_image_url(post) do
    "https:" <> Cloudex.Url.for(post.image_url) <> ".jpg"
  end
end
