defmodule BlogWeb.LayoutView do
  use BlogWeb, :view

  def body_class(conn = %Plug.Conn{private: %{phoenix_controller: _}}) do
    controller_name = format_controller_name(conn)
    "#{format_path(conn)} #{controller_name} #{controller_name}-#{Phoenix.Controller.action_name(conn)}"
    |> String.trim
  end

  def format_controller_name(conn) do
    conn
    |> Phoenix.Controller.controller_module
    |> to_string
    |> String.split(".")
    |> Enum.slice(2..-1)
    |> Enum.join("")
    |> extract_controller
    |> hyphenate 
    |> String.downcase
  end

  @controller_string_length 10
  def extract_controller(name) do 
    name
    |> String.slice(0, String.length(name) - @controller_string_length)
  end

  def hyphenate(name) do 
    Regex.split(~r/(?=[A-Z])/, name, [trim: true])
    |> Enum.join("-")
  end
  
  def format_path(conn) do
    conn.path_info
    |> remove_numbers
    |> Enum.join("-")
  end

  def remove_numbers(path_list) do
    Enum.filter path_list, fn (item) ->
      Integer.parse(item) == :error
    end
  end
end
