defmodule OverstatsWeb.PageControllerTest do
  use OverstatsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/components")
    assert html_response(conn, 200) =~ "Petal"
  end
end
