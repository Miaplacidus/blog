defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.Post

  schema "posts" do
    field :title, :string
    field :description, :string
    field :body, :string
    field :slug, :string
    field :state, :string
    field :author_id, :integer
    field :image_url, :string

    timestamps()
  end

  def changeset(%Post{} = post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description, :body, :slug, :state, :author_id, :image_url])
    |> validate_required([:title, :description, :body, :author_id])
  end
end
