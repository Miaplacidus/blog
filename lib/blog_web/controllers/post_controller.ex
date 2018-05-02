defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Content
  alias Blog.Content.Post
  alias Blog.Accounts
  
  @authors Accounts.list_authors
    |> Enum.map(&{"#{&1.first_name} #{&1.last_name}", &1.id})

  def index(conn, _params) do
    render(conn, "index.html", posts: Content.list_posts(6))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Content.get_post(id))
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})

    render conn, "new.html", changeset: changeset, authors: @authors
  end

  def create(conn, %{"post" => post_params}) do
    case Content.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post saved!")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        put_flash(conn, :error, "See errors below")
        render(conn, "new.html", changeset: changeset, authors: @authors)
      _ ->
        put_flash(conn, :error, "WTF")
        render(conn, "new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    changeset = Content.change_post(post)
    authors =
      Accounts.list_authors
      |> Enum.map(&{"#{&1.first_name} #{&1.last_name}", &1.id})
    render conn, "edit.html", changeset: changeset, post: post, authors: authors
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post = Content.get_post!(id)

    case Content.update_post(post, params) do
      {:ok, _updated_post} ->
        conn
        |> put_flash(:info, "Post successfully updated!")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    {:ok, _post} = Content.delete_post(post)

    conn
    |> put_flash(:info, "Post successfully deleted")
    |> redirect(to: post_path(conn, :index))
  end

  def post_preview(conn, params) do
    %{"post_body" => post_body} = params
    render conn, "preview.json", post_body: post_body
  end
end
