# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Blog.DatabaseSeeder do
  alias Blog.Repo
  alias Blog.Content.Post
  alias Blog.Accounts.Author

  def insert_author do 
    Repo.insert! %Author{
      first_name: "Ada",
      last_name: "Machina",
      email: "adamachina@example.com"
    }
  end

  def insert_post do
    author = Blog.Accounts.find_author("adamachina@example.com")

    Repo.insert! %Post{
      author_id: author.id,
      title: Faker.Lorem.Shakespeare.hamlet(),
      description: Faker.Lorem.Shakespeare.king_richard_iii(),
      body: Faker.Lorem.paragraph(3..7),
      image_url: Faker.Avatar.image_url(),
      slug: String.downcase(Faker.Pizza.pizza()) |> String.replace(" ", "-"),
      published_at: DateTime.truncate(Timex.now, :second),
      original: true
    }
  end

  def clear do
    Repo.delete_all Post
  end

end

Blog.DatabaseSeeder.clear()
# Blog.DatabaseSeeder.insert_author()
(1..15) |> Enum.each(fn _ -> Blog.DatabaseSeeder.insert_post end)