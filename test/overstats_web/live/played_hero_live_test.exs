defmodule OverstatsWeb.PlayedHeroLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.StatsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_played_hero(_) do
    played_hero = played_hero_fixture()
    %{played_hero: played_hero}
  end

  describe "Index" do
    setup [:create_played_hero]

    test "lists all played_heroes", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/played_heroes")

      assert html =~ "Listing Played heroes"
    end

    test "saves new played_hero", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/played_heroes")

      assert index_live |> element("a", "New Played hero") |> render_click() =~
               "New Played hero"

      assert_patch(index_live, ~p"/played_heroes/new")

      assert index_live
             |> form("#played_hero-form", played_hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#played_hero-form", played_hero: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_heroes")

      assert html =~ "Played hero created successfully"
    end

    test "updates played_hero in listing", %{conn: conn, played_hero: played_hero} do
      {:ok, index_live, _html} = live(conn, ~p"/played_heroes")

      assert index_live |> element("#played_heroes-#{played_hero.id} a", "Edit") |> render_click() =~
               "Edit Played hero"

      assert_patch(index_live, ~p"/played_heroes/#{played_hero}/edit")

      assert index_live
             |> form("#played_hero-form", played_hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#played_hero-form", played_hero: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_heroes")

      assert html =~ "Played hero updated successfully"
    end

    test "deletes played_hero in listing", %{conn: conn, played_hero: played_hero} do
      {:ok, index_live, _html} = live(conn, ~p"/played_heroes")

      assert index_live |> element("#played_heroes-#{played_hero.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#played_hero-#{played_hero.id}")
    end
  end

  describe "Show" do
    setup [:create_played_hero]

    test "displays played_hero", %{conn: conn, played_hero: played_hero} do
      {:ok, _show_live, html} = live(conn, ~p"/played_heroes/#{played_hero}")

      assert html =~ "Show Played hero"
    end

    test "updates played_hero within modal", %{conn: conn, played_hero: played_hero} do
      {:ok, show_live, _html} = live(conn, ~p"/played_heroes/#{played_hero}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Played hero"

      assert_patch(show_live, ~p"/played_heroes/#{played_hero}/show/edit")

      assert show_live
             |> form("#played_hero-form", played_hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#played_hero-form", played_hero: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_heroes/#{played_hero}")

      assert html =~ "Played hero updated successfully"
    end
  end
end
