defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    execute """
      create table posts (
        id serial primary key,
        title text not null,
        description text not null default '',
        body text not null default '',
        slug text,
        state text not null default 'draft',
        image_url text, 
        original boolean not null default true,
        published_at timestamptz,
        inserted_at timestamptz not null default now(),
        updated_at timestamptz not null default now()
      );
    """
  end


  def down do
    execute "drop table posts;"
  end
end
