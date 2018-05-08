defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  import Ecto.Query, warn: false

  alias Blog.Content
  alias Blog.Content.Post
  alias Blog.Accounts
  
  def index(conn, params) do
    page_number = 
      Map.get(params, "page_number", 1)
      |> String.to_integer

    page =
      Post
      |> where([p], not is_nil(p.published_at))
      |> order_by(desc: :published_at)
      |> Blog.Repo.paginate(page: page_number, page_size: 5)

    render(conn, 
           "index.html", 
           posts: page.entries,
           page_number: page_number,
           page_size: page.page_size,
           total_pages: page.total_pages,
           total_entries: page.total_entries 
    )
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Content.get_published_post(id))
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})

    render conn, "new.html", changeset: changeset, authors: authors()
  end

  def create(conn, %{"post" => post_params} = params) do
    post_params = save_or_publish(params)

    post_params = case upload_image(post_params) do 
      {:ok, params} ->
        params
      {:error, _} -> 
        post_params
    end

    case Content.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post saved!")
        |> redirect(to: post_path(conn, :admin_index))
      {:error, %Ecto.Changeset{} = changeset} ->
        put_flash(conn, :error, "See errors below")
        render(conn, "new.html", changeset: changeset, authors: authors())
      _ ->
        put_flash(conn, :error, "WTF")
        render(conn, "new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    changeset = Content.change_post(post)
    render conn, "edit.html", changeset: changeset, post: post, authors: authors()
  end

  def update(conn, %{"id" => id, "post" => post_params} = params) do
    post_params = save_or_publish(params)

    post = Content.get_post!(id)

    post_params = case upload_image(post_params) do 
      {:ok, params} ->
        params
      {:error, _} -> 
        post_params
    end

    case Content.update_post(post, post_params) do
      {:ok, _updated_post} ->
        conn
        |> put_flash(:info, "Post successfully updated!")
        |> redirect(to: post_path(conn, :admin_index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset, authors: authors())
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

  def admin_index(conn, _params) do 
    render(conn, "admin_index.html", posts: Content.list_posts(20))
  end

  defp authors do 
    Accounts.list_authors
      |> Enum.map(&{"#{&1.first_name} #{&1.last_name}", &1.id})
  end

  defp upload_image(%{"image_url" => %Plug.Upload{ path: image_path}} = params) do 
    case Cloudex.upload(image_path) do 
      {:ok, image} -> 
        %Cloudex.UploadedImage{public_id: public_id} = image
        {:ok, Map.merge(params, %{"image_url" => public_id})}
      {:error, message} -> 
        {:error, params} 
    end
  end

  defp upload_image(%{"external_resource_url" => ""}) do 
    {:error, "image not updated"} 
  end

  defp upload_image(%{"external_resource_url" => external_resource_url} = params) do 
    %HTTPoison.Response{body: body} = HTTPoison.get! external_resource_url

    [%HTTPoison.Response{request_url: request_url}] = Floki.find(body, "head meta[property='og:image']") 
      |> Floki.attribute("content") 
      |> Enum.map(fn(url) -> HTTPoison.get!(url) end)

    case Cloudex.upload(request_url) do 
      {:ok, image} -> 
        %Cloudex.UploadedImage{public_id: public_id} = image
        {:ok, Map.merge(params, %{"image_url" => public_id})}
      {:error, message} -> 
        {:error, params} 
    end
  end

  defp upload_image(_) do 
    {:error, "image not updated"}
  end

  def save_or_publish(%{"post" => post_params, "publish_post" => %{"state" => "publish"}} = params) do 
    Map.merge(post_params, %{"published_at" => Timex.now}) 
  end

  def save_or_publish(%{"post" => post_params, "publish_post" => %{"state" => "draft"}} = params) do 
    post_params
  end
end
