defmodule ReddixWeb.PageController do
  use ReddixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
