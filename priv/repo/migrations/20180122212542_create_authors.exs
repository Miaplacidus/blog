defmodule Blog.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def up do
    execute """
      create table authors (
        id serial primary key,
        first_name text not null,
        last_name text not null,
        nickname text,
        github_handle text,
        github_token text,
        provider text,
        twitter_handle text,
        github_id text,
        email text not null,
        inserted_at timestamptz not null default now(),
        updated_at timestamptz not null default now()
      );
    """

    execute """
      alter table posts add column author_id integer not null;
    """

    execute """
      alter table posts add constraint posts_author_id_fkey foreign key (author_id) references authors (id);
    """
  end

  def down do
    execute """
      alter table posts
        drop column author_id;
    """

    execute """
      drop table authors cascade;
    """
  end
end
