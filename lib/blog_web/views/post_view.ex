use Timex

defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def to_html(body) do 
    case Panpipe.pandoc(body, to: :html) do 
      {:ok, output} -> 
        output
      _ ->
        "error"
    end
  end

  def safe_html(body) do 
    PostView.to_html(body)
    |> raw
  end

  def display_time(nil) do 
    "No date to display"
  end

  def display_time(time) do
    abbreviation = Timex.Timezone.get("America/Chicago").abbreviation
    {_status, humanized_time } =
      Timex.Timezone.convert(time, "America/Chicago")
      |> Timex.format("%A %B %e, %Y at %I:%M %P", :strftime)
    humanized_time <> " #{abbreviation}"
  end

  def display_short_time(nil) do 
    "No date to display"
  end

  def display_short_time(time) do 
    {_status, humanized_time } =
      Timex.Timezone.convert(time, "America/Chicago")
      |> Timex.format("%-m/%-d/%Y, %l:%M%P", :strftime)
    humanized_time 
  end

  def render("preview.json", %{post_body: post_body}) do
    %{ data: %{ post_body: PostView.to_html(post_body) }}
  end

  def generate_image_url(post) do
    "https:" <> Cloudex.Url.for(post.image_url) <> ".jpg"
  end

  def chevron_page_number("left", 1) do 
    1
  end

  def chevron_page_number("left", current_page_number) do
    current_page_number - 1
  end

  def chevron_page_number("right", current_page_number, total_pages) do 
    case current_page_number == total_pages do
      true ->
        current_page_number
      false ->
        current_page_number + 1
    end
  end

  def active_page(link_number, current_page_number) do 
    case link_number == current_page_number do 
      true ->
        "active"
      false ->
        "inactive"
    end
  end

  def link_post(post) do 
    case post.original do 
      true -> 
        "original-post"
      false ->
        "link-post"
    end
  end

  def publish_state_selected_value(post) do
    case not is_nil(post.published_at) do 
      true -> "publish"
      false -> "draft"
    end
  end
end
