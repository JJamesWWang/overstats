defmodule OverstatsWeb.PageController do
  use OverstatsWeb, :controller

  def home(conn, _params) do
    render(conn, :home, active_tab: :home)
  end
end
