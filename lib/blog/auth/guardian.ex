defmodule Blog.Guardian do 
  use Guardian, otp_app: :blog

  def subject_for_token(author, _claims) do 
    { :ok, to_string(author.id) }
  end

  def resource_from_claims(%{ "sub" => id}) do
    case Blog.Accounts.get_author(id) do 
      author -> { :ok, author }
      nil -> { :error, :resource_not_found }
    end
  end
end
