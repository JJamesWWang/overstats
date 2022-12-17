defmodule Overstats.OverwatchTest do
  use Overstats.DataCase

  alias Overstats.Overwatch

  describe "heroes" do
    alias Overstats.Overwatch.Hero

    import Overstats.OverwatchFixtures

    @invalid_attrs %{name: nil, role: nil}

    test "list_heroes/0 returns all heroes" do
      hero = hero_fixture()
      assert Overwatch.list_heroes() == [hero]
    end

    test "get_hero!/1 returns the hero with given id" do
      hero = hero_fixture()
      assert Overwatch.get_hero!(hero.id) == hero
    end

    test "create_hero/1 with valid data creates a hero" do
      valid_attrs = %{name: "some name", role: "some role"}

      assert {:ok, %Hero{} = hero} = Overwatch.create_hero(valid_attrs)
      assert hero.name == "some name"
      assert hero.role == "some role"
    end

    test "create_hero/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Overwatch.create_hero(@invalid_attrs)
    end

    test "update_hero/2 with valid data updates the hero" do
      hero = hero_fixture()
      update_attrs = %{name: "some updated name", role: "some updated role"}

      assert {:ok, %Hero{} = hero} = Overwatch.update_hero(hero, update_attrs)
      assert hero.name == "some updated name"
      assert hero.role == "some updated role"
    end

    test "update_hero/2 with invalid data returns error changeset" do
      hero = hero_fixture()
      assert {:error, %Ecto.Changeset{}} = Overwatch.update_hero(hero, @invalid_attrs)
      assert hero == Overwatch.get_hero!(hero.id)
    end

    test "delete_hero/1 deletes the hero" do
      hero = hero_fixture()
      assert {:ok, %Hero{}} = Overwatch.delete_hero(hero)
      assert_raise Ecto.NoResultsError, fn -> Overwatch.get_hero!(hero.id) end
    end

    test "change_hero/1 returns a hero changeset" do
      hero = hero_fixture()
      assert %Ecto.Changeset{} = Overwatch.change_hero(hero)
    end
  end

  describe "maps" do
    alias Overstats.Overwatch.Map

    import Overstats.OverwatchFixtures

    @invalid_attrs %{name: nil, type: nil}

    test "list_maps/0 returns all maps" do
      map = map_fixture()
      assert Overwatch.list_maps() == [map]
    end

    test "get_map!/1 returns the map with given id" do
      map = map_fixture()
      assert Overwatch.get_map!(map.id) == map
    end

    test "create_map/1 with valid data creates a map" do
      valid_attrs = %{name: "some name", type: "some type"}

      assert {:ok, %Map{} = map} = Overwatch.create_map(valid_attrs)
      assert map.name == "some name"
      assert map.type == "some type"
    end

    test "create_map/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Overwatch.create_map(@invalid_attrs)
    end

    test "update_map/2 with valid data updates the map" do
      map = map_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type"}

      assert {:ok, %Map{} = map} = Overwatch.update_map(map, update_attrs)
      assert map.name == "some updated name"
      assert map.type == "some updated type"
    end

    test "update_map/2 with invalid data returns error changeset" do
      map = map_fixture()
      assert {:error, %Ecto.Changeset{}} = Overwatch.update_map(map, @invalid_attrs)
      assert map == Overwatch.get_map!(map.id)
    end

    test "delete_map/1 deletes the map" do
      map = map_fixture()
      assert {:ok, %Map{}} = Overwatch.delete_map(map)
      assert_raise Ecto.NoResultsError, fn -> Overwatch.get_map!(map.id) end
    end

    test "change_map/1 returns a map changeset" do
      map = map_fixture()
      assert %Ecto.Changeset{} = Overwatch.change_map(map)
    end
  end
end
