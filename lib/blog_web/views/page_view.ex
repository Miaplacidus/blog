defmodule BlogWeb.PageView do
  use BlogWeb, :view

  def generate_image_url(post) do
    "https:" <> Cloudex.Url.for(post.image_url) <> ".jpg"
  end
end
