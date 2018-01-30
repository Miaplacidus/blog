defmodule Blog.Accounts.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.Author

  schema "authors" do
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    field :github_handle, :string
    field :github_token, :string
    field :provider, :string
    field :twitter_handle, :string
    field :github_id, :string
    field :email, :string

    timestamps()
  end

  def changeset(%Author{}=author, attrs \\ %{}) do
    author
    |> cast(attrs, [:first_name, :last_name, :nickname, :github_handle, :github_token, :provider, :twitter_handle, :github_id, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
