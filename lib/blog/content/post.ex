defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.Post

  schema "posts" do
    field :author_id, :integer
    field :title, :string
    field :description, :string
    field :body, :string
    field :published, :boolean
    field :image_url, :string
    field :original, :boolean
    field :published_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  def changeset(%Post{} = post, attrs \\ %{}) do
    post
    |> cast(attrs, [:author_id, :title, :description, :body, :published, :image_url, :original, :published_at])
    |> validate_required([:author_id, :title, :description, :body, :published, :original])
  end
end
