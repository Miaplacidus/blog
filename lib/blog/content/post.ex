defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.Post

  schema "posts" do
    belongs_to :author, Blog.Accounts.Author
    field :title, :string
    field :description, :string
    field :body, :string
    field :published, :boolean
    field :image_url, :string
    field :original, :boolean
    field :published_at, :utc_datetime

    timestamps()
  end

  def changeset(%Post{} = post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description, :body, :published, :image_url, :original, :published_at])
    |> validate_required([:title, :description, :body, :published, :original])
  end
end
