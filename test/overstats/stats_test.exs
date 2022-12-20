defmodule Overstats.StatsTest do
  use Overstats.DataCase

  alias Overstats.Stats
  alias Overstats.GamesFixtures
  alias Overstats.OverwatchFixtures
  alias Overstats.PlayersFixtures

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
      game = GamesFixtures.game_fixture()
      player = PlayersFixtures.player_fixture()
      valid_attrs = %{won?: true, game_id: game.id, player_id: player.id}

      assert {:ok, %PlayedGame{} = played_game} = Stats.create_played_game(valid_attrs)
      assert played_game.won? == true
      assert played_game.game_id == game.id
      assert played_game.player_id == player.id
    end

    test "create_played_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_played_game(@invalid_attrs)
    end

    test "update_played_game/2 with valid data updates the played_game" do
      played_game = played_game_fixture()
      update_attrs = %{won?: false}

      assert {:ok, %PlayedGame{} = played_game} =
               Stats.update_played_game(played_game, update_attrs)

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

    @invalid_attrs %{game_id: 0}

    test "list_played_heroes/0 returns all played_heroes" do
      played_hero = played_hero_fixture()
      assert Stats.list_played_heroes() == [played_hero]
    end

    test "get_played_hero!/1 returns the played_hero with given id" do
      played_hero = played_hero_fixture()
      assert Stats.get_played_hero!(played_hero.id) == played_hero
    end

    test "create_played_hero/1 with valid data creates a played_hero" do
      game = GamesFixtures.game_fixture()
      player = PlayersFixtures.player_fixture()
      hero = OverwatchFixtures.hero_fixture()
      valid_attrs = %{game_id: game.id, player_id: player.id, hero_id: hero.id}

      assert {:ok, %PlayedHero{} = played_hero} = Stats.create_played_hero(valid_attrs)
      assert played_hero.game_id == game.id
      assert played_hero.player_id == player.id
      assert played_hero.hero_id == hero.id
    end

    test "create_played_hero/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_played_hero(@invalid_attrs)
    end

    test "update_played_hero/2 with valid data updates the played_hero" do
      played_hero = played_hero_fixture()
      hero = OverwatchFixtures.hero_fixture()
      update_attrs = %{hero_id: hero.id}

      assert {:ok, %PlayedHero{} = played_hero} =
               Stats.update_played_hero(played_hero, update_attrs)

      assert played_hero.hero_id == hero.id
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

    @invalid_attrs %{game_id: 0}

    test "list_plays_of_the_game/0 returns all plays_of_the_game" do
      play_of_the_game = play_of_the_game_fixture()
      assert Stats.list_plays_of_the_game() == [play_of_the_game]
    end

    test "get_play_of_the_game!/1 returns the play_of_the_game with given id" do
      play_of_the_game = play_of_the_game_fixture()
      assert Stats.get_play_of_the_game!(play_of_the_game.id) == play_of_the_game
    end

    test "create_play_of_the_game/1 with valid data creates a play_of_the_game" do
      game = GamesFixtures.game_fixture()
      player = PlayersFixtures.player_fixture()
      hero = OverwatchFixtures.hero_fixture()
      valid_attrs = %{game_id: game.id, player_id: player.id, hero_id: hero.id}

      assert {:ok, %PlayOfTheGame{} = play_of_the_game} =
               Stats.create_play_of_the_game(valid_attrs)

      assert play_of_the_game.game_id == game.id
      assert play_of_the_game.player_id == player.id
      assert play_of_the_game.hero_id == hero.id
    end

    test "create_play_of_the_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_play_of_the_game(@invalid_attrs)
    end

    test "update_play_of_the_game/2 with valid data updates the play_of_the_game" do
      play_of_the_game = play_of_the_game_fixture()
      hero = OverwatchFixtures.hero_fixture()
      update_attrs = %{hero_id: hero.id}

      assert {:ok, %PlayOfTheGame{} = play_of_the_game} =
               Stats.update_play_of_the_game(play_of_the_game, update_attrs)

      assert play_of_the_game.hero_id == hero.id
    end

    test "update_play_of_the_game/2 with invalid data returns error changeset" do
      play_of_the_game = play_of_the_game_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_play_of_the_game(play_of_the_game, @invalid_attrs)

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
end
