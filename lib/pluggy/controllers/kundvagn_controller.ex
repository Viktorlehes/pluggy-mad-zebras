defmodule Pluggy.KundvagnController do
  require IEx

  import Pluggy.Template, only: [render: 1]
  import Plug.Conn, only: [send_resp: 3]

  alias Pluggy.Order

  def index(conn), do: send_resp(conn, 200, render("kundvagn/index"))

  def create(conn, params) do
    Order.create(params)
    redirect(conn, "/meny")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
