defmodule OverstatsWeb.GameMapLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.StatsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_game_map(_) do
    game_map = game_map_fixture()
    %{game_map: game_map}
  end

  describe "Index" do
    setup [:create_game_map]

    test "lists all game_maps", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/game_maps")

      assert html =~ "Listing Game maps"
    end

    test "saves new game_map", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/game_maps")

      assert index_live |> element("a", "New Game map") |> render_click() =~
               "New Game map"

      assert_patch(index_live, ~p"/game_maps/new")

      assert index_live
             |> form("#game_map-form", game_map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game_map-form", game_map: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/game_maps")

      assert html =~ "Game map created successfully"
    end

    test "updates game_map in listing", %{conn: conn, game_map: game_map} do
      {:ok, index_live, _html} = live(conn, ~p"/game_maps")

      assert index_live |> element("#game_maps-#{game_map.id} a", "Edit") |> render_click() =~
               "Edit Game map"

      assert_patch(index_live, ~p"/game_maps/#{game_map}/edit")

      assert index_live
             |> form("#game_map-form", game_map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game_map-form", game_map: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/game_maps")

      assert html =~ "Game map updated successfully"
    end

    test "deletes game_map in listing", %{conn: conn, game_map: game_map} do
      {:ok, index_live, _html} = live(conn, ~p"/game_maps")

      assert index_live |> element("#game_maps-#{game_map.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#game_map-#{game_map.id}")
    end
  end

  describe "Show" do
    setup [:create_game_map]

    test "displays game_map", %{conn: conn, game_map: game_map} do
      {:ok, _show_live, html} = live(conn, ~p"/game_maps/#{game_map}")

      assert html =~ "Show Game map"
    end

    test "updates game_map within modal", %{conn: conn, game_map: game_map} do
      {:ok, show_live, _html} = live(conn, ~p"/game_maps/#{game_map}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Game map"

      assert_patch(show_live, ~p"/game_maps/#{game_map}/show/edit")

      assert show_live
             |> form("#game_map-form", game_map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#game_map-form", game_map: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/game_maps/#{game_map}")

      assert html =~ "Game map updated successfully"
    end
  end
end
