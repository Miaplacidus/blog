defmodule BlogWeb.Router do
  use BlogWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :require_auth do
    plug Blog.Auth.Pipeline
  end

  scope "/", BlogWeb do 
    pipe_through [:browser, :require_auth]

    resources "/posts", PostController, only: [:new, :create, :edit, :update, :delete] 
    get "/admin/posts", PostController, :admin_index
  end
  
  scope "/", BlogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/posts", PostController, only: [:index, :show]
    get "/admin-signin", AuthController, :admin_signin
    post "/post-preview", PostController, :post_preview
    get "/download_resume", DocumentController, :download_resume
    get "/download_physnet_paper", DocumentController, :download_physnet_paper
  end

  scope "/auth", BlogWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogWeb do
  #   pipe_through :api
  # end
end
