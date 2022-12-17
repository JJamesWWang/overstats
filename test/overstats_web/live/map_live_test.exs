defmodule OverstatsWeb.MapLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.OverwatchFixtures

  @create_attrs %{name: "some name", type: "some type"}
  @update_attrs %{name: "some updated name", type: "some updated type"}
  @invalid_attrs %{name: nil, type: nil}

  defp create_map(_) do
    map = map_fixture()
    %{map: map}
  end

  describe "Index" do
    setup [:create_map]

    test "lists all maps", %{conn: conn, map: map} do
      {:ok, _index_live, html} = live(conn, ~p"/maps")

      assert html =~ "Listing Maps"
      assert html =~ map.name
    end

    test "saves new map", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert index_live |> element("a", "New Map") |> render_click() =~
               "New Map"

      assert_patch(index_live, ~p"/maps/new")

      assert index_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#map-form", map: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/maps")

      assert html =~ "Map created successfully"
      assert html =~ "some name"
    end

    test "updates map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert index_live |> element("#maps-#{map.id} a", "Edit") |> render_click() =~
               "Edit Map"

      assert_patch(index_live, ~p"/maps/#{map}/edit")

      assert index_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#map-form", map: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/maps")

      assert html =~ "Map updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert index_live |> element("#maps-#{map.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#map-#{map.id}")
    end
  end

  describe "Show" do
    setup [:create_map]

    test "displays map", %{conn: conn, map: map} do
      {:ok, _show_live, html} = live(conn, ~p"/maps/#{map}")

      assert html =~ "Show Map"
      assert html =~ map.name
    end

    test "updates map within modal", %{conn: conn, map: map} do
      {:ok, show_live, _html} = live(conn, ~p"/maps/#{map}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Map"

      assert_patch(show_live, ~p"/maps/#{map}/show/edit")

      assert show_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#map-form", map: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/maps/#{map}")

      assert html =~ "Map updated successfully"
      assert html =~ "some updated name"
    end
  end
end
