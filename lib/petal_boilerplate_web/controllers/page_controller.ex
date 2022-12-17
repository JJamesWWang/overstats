defmodule OverStatsWeb.PageController do
  use OverStatsWeb, :controller

  def home(conn, _params) do
    render(conn, :home, active_tab: :home)
  end
end
