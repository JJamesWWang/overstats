defmodule Overstats.StatsTest do
  use Overstats.DataCase

  alias Overstats.Stats

  describe "played_games" do
    alias Overstats.Stats.PlayedGame

    import Overstats.StatsFixtures

    @invalid_attrs %{won?: nil}

    test "list_played_games/0 returns all played_games" do
      played_game = played_game_fixture()
      assert Stats.list_played_games() == [played_game]
    end

    test "get_played_game!/1 returns the played_game with given id" do
      played_game = played_game_fixture()
      assert Stats.get_played_game!(played_game.id) == played_game
    end

    test "create_played_game/1 with valid data creates a played_game" do
      valid_attrs = %{won?: true}

      assert {:ok, %PlayedGame{} = played_game} = Stats.create_played_game(valid_attrs)
      assert played_game.won? == true
    end

    test "create_played_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_played_game(@invalid_attrs)
    end

    test "update_played_game/2 with valid data updates the played_game" do
      played_game = played_game_fixture()
      update_attrs = %{won?: false}

      assert {:ok, %PlayedGame{} = played_game} = Stats.update_played_game(played_game, update_attrs)
      assert played_game.won? == false
    end

    test "update_played_game/2 with invalid data returns error changeset" do
      played_game = played_game_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_played_game(played_game, @invalid_attrs)
      assert played_game == Stats.get_played_game!(played_game.id)
    end

    test "delete_played_game/1 deletes the played_game" do
      played_game = played_game_fixture()
      assert {:ok, %PlayedGame{}} = Stats.delete_played_game(played_game)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_played_game!(played_game.id) end
    end

    test "change_played_game/1 returns a played_game changeset" do
      played_game = played_game_fixture()
      assert %Ecto.Changeset{} = Stats.change_played_game(played_game)
    end
  end

  describe "played_heroes" do
    alias Overstats.Stats.PlayedHero

    import Overstats.StatsFixtures

    @invalid_attrs %{}

    test "list_played_heroes/0 returns all played_heroes" do
      played_hero = played_hero_fixture()
      assert Stats.list_played_heroes() == [played_hero]
    end

    test "get_played_hero!/1 returns the played_hero with given id" do
      played_hero = played_hero_fixture()
      assert Stats.get_played_hero!(played_hero.id) == played_hero
    end

    test "create_played_hero/1 with valid data creates a played_hero" do
      valid_attrs = %{}

      assert {:ok, %PlayedHero{} = played_hero} = Stats.create_played_hero(valid_attrs)
    end

    test "create_played_hero/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_played_hero(@invalid_attrs)
    end

    test "update_played_hero/2 with valid data updates the played_hero" do
      played_hero = played_hero_fixture()
      update_attrs = %{}

      assert {:ok, %PlayedHero{} = played_hero} = Stats.update_played_hero(played_hero, update_attrs)
    end

    test "update_played_hero/2 with invalid data returns error changeset" do
      played_hero = played_hero_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_played_hero(played_hero, @invalid_attrs)
      assert played_hero == Stats.get_played_hero!(played_hero.id)
    end

    test "delete_played_hero/1 deletes the played_hero" do
      played_hero = played_hero_fixture()
      assert {:ok, %PlayedHero{}} = Stats.delete_played_hero(played_hero)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_played_hero!(played_hero.id) end
    end

    test "change_played_hero/1 returns a played_hero changeset" do
      played_hero = played_hero_fixture()
      assert %Ecto.Changeset{} = Stats.change_played_hero(played_hero)
    end
  end

  describe "plays_of_the_game" do
    alias Overstats.Stats.PlayOfTheGame

    import Overstats.StatsFixtures

    @invalid_attrs %{}

    test "list_plays_of_the_game/0 returns all plays_of_the_game" do
      play_of_the_game = play_of_the_game_fixture()
      assert Stats.list_plays_of_the_game() == [play_of_the_game]
    end

    test "get_play_of_the_game!/1 returns the play_of_the_game with given id" do
      play_of_the_game = play_of_the_game_fixture()
      assert Stats.get_play_of_the_game!(play_of_the_game.id) == play_of_the_game
    end

    test "create_play_of_the_game/1 with valid data creates a play_of_the_game" do
      valid_attrs = %{}

      assert {:ok, %PlayOfTheGame{} = play_of_the_game} = Stats.create_play_of_the_game(valid_attrs)
    end

    test "create_play_of_the_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_play_of_the_game(@invalid_attrs)
    end

    test "update_play_of_the_game/2 with valid data updates the play_of_the_game" do
      play_of_the_game = play_of_the_game_fixture()
      update_attrs = %{}

      assert {:ok, %PlayOfTheGame{} = play_of_the_game} = Stats.update_play_of_the_game(play_of_the_game, update_attrs)
    end

    test "update_play_of_the_game/2 with invalid data returns error changeset" do
      play_of_the_game = play_of_the_game_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_play_of_the_game(play_of_the_game, @invalid_attrs)
      assert play_of_the_game == Stats.get_play_of_the_game!(play_of_the_game.id)
    end

    test "delete_play_of_the_game/1 deletes the play_of_the_game" do
      play_of_the_game = play_of_the_game_fixture()
      assert {:ok, %PlayOfTheGame{}} = Stats.delete_play_of_the_game(play_of_the_game)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_play_of_the_game!(play_of_the_game.id) end
    end

    test "change_play_of_the_game/1 returns a play_of_the_game changeset" do
      play_of_the_game = play_of_the_game_fixture()
      assert %Ecto.Changeset{} = Stats.change_play_of_the_game(play_of_the_game)
    end
  end

  describe "game_maps" do
    alias Overstats.Stats.GameMap

    import Overstats.StatsFixtures

    @invalid_attrs %{}

    test "list_game_maps/0 returns all game_maps" do
      game_map = game_map_fixture()
      assert Stats.list_game_maps() == [game_map]
    end

    test "get_game_map!/1 returns the game_map with given id" do
      game_map = game_map_fixture()
      assert Stats.get_game_map!(game_map.id) == game_map
    end

    test "create_game_map/1 with valid data creates a game_map" do
      valid_attrs = %{}

      assert {:ok, %GameMap{} = game_map} = Stats.create_game_map(valid_attrs)
    end

    test "create_game_map/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_game_map(@invalid_attrs)
    end

    test "update_game_map/2 with valid data updates the game_map" do
      game_map = game_map_fixture()
      update_attrs = %{}

      assert {:ok, %GameMap{} = game_map} = Stats.update_game_map(game_map, update_attrs)
    end

    test "update_game_map/2 with invalid data returns error changeset" do
      game_map = game_map_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_game_map(game_map, @invalid_attrs)
      assert game_map == Stats.get_game_map!(game_map.id)
    end

    test "delete_game_map/1 deletes the game_map" do
      game_map = game_map_fixture()
      assert {:ok, %GameMap{}} = Stats.delete_game_map(game_map)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_game_map!(game_map.id) end
    end

    test "change_game_map/1 returns a game_map changeset" do
      game_map = game_map_fixture()
      assert %Ecto.Changeset{} = Stats.change_game_map(game_map)
    end
  end
end
