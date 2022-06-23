defmodule LightCreditWeb.PageController do
  use LightCreditWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
