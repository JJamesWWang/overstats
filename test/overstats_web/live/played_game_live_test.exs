defmodule OverstatsWeb.PlayedGameLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.StatsFixtures

  @create_attrs %{won?: true}
  @update_attrs %{won?: false}
  @invalid_attrs %{won?: false}

  defp create_played_game(_) do
    played_game = played_game_fixture()
    %{played_game: played_game}
  end

  describe "Index" do
    setup [:create_played_game]

    test "lists all played_games", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/played_games")

      assert html =~ "Listing Played games"
    end

    test "saves new played_game", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/played_games")

      assert index_live |> element("a", "New Played game") |> render_click() =~
               "New Played game"

      assert_patch(index_live, ~p"/played_games/new")

      assert index_live
             |> form("#played_game-form", played_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#played_game-form", played_game: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_games")

      assert html =~ "Played game created successfully"
    end

    test "updates played_game in listing", %{conn: conn, played_game: played_game} do
      {:ok, index_live, _html} = live(conn, ~p"/played_games")

      assert index_live |> element("#played_games-#{played_game.id} a", "Edit") |> render_click() =~
               "Edit Played game"

      assert_patch(index_live, ~p"/played_games/#{played_game}/edit")

      assert index_live
             |> form("#played_game-form", played_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#played_game-form", played_game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_games")

      assert html =~ "Played game updated successfully"
    end

    test "deletes played_game in listing", %{conn: conn, played_game: played_game} do
      {:ok, index_live, _html} = live(conn, ~p"/played_games")

      assert index_live |> element("#played_games-#{played_game.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#played_game-#{played_game.id}")
    end
  end

  describe "Show" do
    setup [:create_played_game]

    test "displays played_game", %{conn: conn, played_game: played_game} do
      {:ok, _show_live, html} = live(conn, ~p"/played_games/#{played_game}")

      assert html =~ "Show Played game"
    end

    test "updates played_game within modal", %{conn: conn, played_game: played_game} do
      {:ok, show_live, _html} = live(conn, ~p"/played_games/#{played_game}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Played game"

      assert_patch(show_live, ~p"/played_games/#{played_game}/show/edit")

      assert show_live
             |> form("#played_game-form", played_game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#played_game-form", played_game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/played_games/#{played_game}")

      assert html =~ "Played game updated successfully"
    end
  end
end
