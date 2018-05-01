defmodule Blog.Content do
  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.Content.Post

  def list_posts(num) do
    query = from p in Post, order_by: [desc: p.published_at], limit: ^num
    Repo.all(query)
  end

  def get_post(post_id) do
    Repo.get(Post, post_id)
  end

  def get_post!(post_id) do
    Repo.get!(Post, post_id)
  end

  @doc """
    creates a new post
  """

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    Returns %Ecto.Changeset{}. Useful for tracking changes in posts.
  """

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end
