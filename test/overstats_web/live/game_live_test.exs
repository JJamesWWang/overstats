defmodule OverstatsWeb.GameLiveTest do
  use OverstatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Overstats.GamesFixtures

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end

  describe "Index" do
    setup [:create_game]

    test "lists all games", %{conn: conn, game: game} do
      {:ok, _index_live, html} = live(conn, ~p"/games")

      assert html =~ "Listing Games"
      assert html =~ game.type
    end

    test "saves new game", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/games")

      assert index_live |> element("a", "New Game") |> render_click() =~
               "New Game"

      assert_patch(index_live, ~p"/games/new")

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game-form", game: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/games")

      assert html =~ "Game created successfully"
      assert html =~ "some type"
    end

    test "updates game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, ~p"/games")

      assert index_live |> element("#games-#{game.id} a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(index_live, ~p"/games/#{game}/edit")

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game-form", game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/games")

      assert html =~ "Game updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, ~p"/games")

      assert index_live |> element("#games-#{game.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#game-#{game.id}")
    end
  end

  describe "Show" do
    setup [:create_game]

    test "displays game", %{conn: conn, game: game} do
      {:ok, _show_live, html} = live(conn, ~p"/games/#{game}")

      assert html =~ "Show Game"
      assert html =~ game.type
    end

    test "updates game within modal", %{conn: conn, game: game} do
      {:ok, show_live, _html} = live(conn, ~p"/games/#{game}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(show_live, ~p"/games/#{game}/show/edit")

      assert show_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#game-form", game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/games/#{game}")

      assert html =~ "Game updated successfully"
      assert html =~ "some updated type"
    end
  end
end
