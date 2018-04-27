use Timex

defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def to_html(body) do 
    tmp_dir_path = Path.join(System.tmp_dir, "post_body.md")
    File.write(tmp_dir_path, body)
    
    pandoc_exe = System.find_executable("pandoc")
    args = [tmp_dir_path, "--from", "markdown", "--to", "html"]

    port = Port.open({:spawn_executable, pandoc_exe}, [:hide, :stderr_to_stdout, :binary, {:args, args}, :exit_status, :use_stdio, :stream])

    body_as_html = receive do 
      {^port, {:data, html}} -> html
      _ -> "I'm sorry, Dave."
    end

    send port, {self(), :close}
    
    body_as_html
  end

  def safe_html(body) do 
    PostView.to_html(body)
    |> raw
  end

  def display_time(time) do
    {status, humanized_time } = Timex.format(time, "%A %B %e, %Y", :strftime)
    humanized_time
  end

  def render("preview.json", %{post_body: post_body}) do
    %{ data: %{ post_body: BlogWeb.PostView.to_html(post_body) }}
  end
end
