defmodule OverstatsWeb.PlayOfTheGameLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.StatsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_play_of_the_game(_) do
    play_of_the_game = play_of_the_game_fixture()
    %{play_of_the_game: play_of_the_game}
  end

  describe "Index" do
    setup [:create_play_of_the_game]

    test "lists all plays_of_the_game", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/plays_of_the_game")

      assert html =~ "Listing Plays of the game"
    end

    test "saves new play_of_the_game", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/plays_of_the_game")

      assert index_live |> element("a", "New Play of the game") |> render_click() =~
               "New Play of the game"

      assert_patch(index_live, ~p"/plays_of_the_game/new")

      assert index_live
             |> form("#play_of_the_game-form", play_of_the_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#play_of_the_game-form", play_of_the_game: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/plays_of_the_game")

      assert html =~ "Play of the game created successfully"
    end

    test "updates play_of_the_game in listing", %{conn: conn, play_of_the_game: play_of_the_game} do
      {:ok, index_live, _html} = live(conn, ~p"/plays_of_the_game")

      assert index_live |> element("#plays_of_the_game-#{play_of_the_game.id} a", "Edit") |> render_click() =~
               "Edit Play of the game"

      assert_patch(index_live, ~p"/plays_of_the_game/#{play_of_the_game}/edit")

      assert index_live
             |> form("#play_of_the_game-form", play_of_the_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#play_of_the_game-form", play_of_the_game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/plays_of_the_game")

      assert html =~ "Play of the game updated successfully"
    end

    test "deletes play_of_the_game in listing", %{conn: conn, play_of_the_game: play_of_the_game} do
      {:ok, index_live, _html} = live(conn, ~p"/plays_of_the_game")

      assert index_live |> element("#plays_of_the_game-#{play_of_the_game.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#play_of_the_game-#{play_of_the_game.id}")
    end
  end

  describe "Show" do
    setup [:create_play_of_the_game]

    test "displays play_of_the_game", %{conn: conn, play_of_the_game: play_of_the_game} do
      {:ok, _show_live, html} = live(conn, ~p"/plays_of_the_game/#{play_of_the_game}")

      assert html =~ "Show Play of the game"
    end

    test "updates play_of_the_game within modal", %{conn: conn, play_of_the_game: play_of_the_game} do
      {:ok, show_live, _html} = live(conn, ~p"/plays_of_the_game/#{play_of_the_game}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Play of the game"

      assert_patch(show_live, ~p"/plays_of_the_game/#{play_of_the_game}/show/edit")

      assert show_live
             |> form("#play_of_the_game-form", play_of_the_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#play_of_the_game-form", play_of_the_game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/plays_of_the_game/#{play_of_the_game}")

      assert html =~ "Play of the game updated successfully"
    end
  end
end
