defmodule Pluggy.KundvagnController do
  require IEx

  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn), do: send_resp(conn, 200, render("kundvagn/index", []))
end
