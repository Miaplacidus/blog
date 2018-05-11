defmodule Blog.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def up do 
    execute """
      alter table posts add column slug text constraint unique_slug unique;
    """
  end

  def down do 
    execute """
      alter table posts drop column slug; 
    """
  end
end
