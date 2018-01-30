defmodule Blog.Accounts do
  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.Accounts.Author

  def list_authors do
    Repo.all(Author)
  end

  def get_author(author_id) do
    Repo.get(Author, author_id)
  end

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end
end
