defmodule Blog.Accounts.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.Author

  schema "authors" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(%Author{}=author, attrs \\ %{}) do
    author
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
