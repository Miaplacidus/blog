defmodule Blog.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def up do
    execute """
      create table authors(
        id serial primary key,
        first_name text not null,
        last_name text not null,
        email text not null,
        inserted_at timestamptz not null default now(),
        updated_at timestamptz not null default now()
      );
    """
  end

  def down do 
    execute """
      drop table authors cascade;
    """
  end
end
