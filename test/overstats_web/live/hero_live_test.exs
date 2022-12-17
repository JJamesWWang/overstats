defmodule OverstatsWeb.HeroLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.OverwatchFixtures

  @create_attrs %{name: "some name", role: "some role"}
  @update_attrs %{name: "some updated name", role: "some updated role"}
  @invalid_attrs %{name: nil, role: nil}

  defp create_hero(_) do
    hero = hero_fixture()
    %{hero: hero}
  end

  describe "Index" do
    setup [:create_hero]

    test "lists all heroes", %{conn: conn, hero: hero} do
      {:ok, _index_live, html} = live(conn, ~p"/heroes")

      assert html =~ "Listing Heroes"
      assert html =~ hero.name
    end

    test "saves new hero", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/heroes")

      assert index_live |> element("a", "New Hero") |> render_click() =~
               "New Hero"

      assert_patch(index_live, ~p"/heroes/new")

      assert index_live
             |> form("#hero-form", hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hero-form", hero: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/heroes")

      assert html =~ "Hero created successfully"
      assert html =~ "some name"
    end

    test "updates hero in listing", %{conn: conn, hero: hero} do
      {:ok, index_live, _html} = live(conn, ~p"/heroes")

      assert index_live |> element("#heroes-#{hero.id} a", "Edit") |> render_click() =~
               "Edit Hero"

      assert_patch(index_live, ~p"/heroes/#{hero}/edit")

      assert index_live
             |> form("#hero-form", hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hero-form", hero: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/heroes")

      assert html =~ "Hero updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes hero in listing", %{conn: conn, hero: hero} do
      {:ok, index_live, _html} = live(conn, ~p"/heroes")

      assert index_live |> element("#heroes-#{hero.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hero-#{hero.id}")
    end
  end

  describe "Show" do
    setup [:create_hero]

    test "displays hero", %{conn: conn, hero: hero} do
      {:ok, _show_live, html} = live(conn, ~p"/heroes/#{hero}")

      assert html =~ "Show Hero"
      assert html =~ hero.name
    end

    test "updates hero within modal", %{conn: conn, hero: hero} do
      {:ok, show_live, _html} = live(conn, ~p"/heroes/#{hero}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hero"

      assert_patch(show_live, ~p"/heroes/#{hero}/show/edit")

      assert show_live
             |> form("#hero-form", hero: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#hero-form", hero: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/heroes/#{hero}")

      assert html =~ "Hero updated successfully"
      assert html =~ "some updated name"
    end
  end
end
