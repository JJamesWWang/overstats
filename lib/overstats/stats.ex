defmodule Overstats.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias Overstats.Repo

  alias Overstats.Stats.PlayedGame

  @doc """
  Returns the list of played_games.

  ## Examples

      iex> list_played_games()
      [%PlayedGame{}, ...]

  """
  def list_played_games do
    Repo.all(PlayedGame)
  end

  @doc """
  Gets a single played_game.

  Raises `Ecto.NoResultsError` if the Played game does not exist.

  ## Examples

      iex> get_played_game!(123)
      %PlayedGame{}

      iex> get_played_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_played_game!(id), do: Repo.get!(PlayedGame, id)

  @doc """
  Creates a played_game.

  ## Examples

      iex> create_played_game(%{field: value})
      {:ok, %PlayedGame{}}

      iex> create_played_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_played_game(attrs \\ %{}) do
    %PlayedGame{}
    |> PlayedGame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a played_game.

  ## Examples

      iex> update_played_game(played_game, %{field: new_value})
      {:ok, %PlayedGame{}}

      iex> update_played_game(played_game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_played_game(%PlayedGame{} = played_game, attrs) do
    played_game
    |> PlayedGame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a played_game.

  ## Examples

      iex> delete_played_game(played_game)
      {:ok, %PlayedGame{}}

      iex> delete_played_game(played_game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_played_game(%PlayedGame{} = played_game) do
    Repo.delete(played_game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking played_game changes.

  ## Examples

      iex> change_played_game(played_game)
      %Ecto.Changeset{data: %PlayedGame{}}

  """
  def change_played_game(%PlayedGame{} = played_game, attrs \\ %{}) do
    PlayedGame.changeset(played_game, attrs)
  end

  alias Overstats.Stats.PlayedHero

  @doc """
  Returns the list of played_heroes.

  ## Examples

      iex> list_played_heroes()
      [%PlayedHero{}, ...]

  """
  def list_played_heroes do
    Repo.all(PlayedHero)
  end

  @doc """
  Gets a single played_hero.

  Raises `Ecto.NoResultsError` if the Played hero does not exist.

  ## Examples

      iex> get_played_hero!(123)
      %PlayedHero{}

      iex> get_played_hero!(456)
      ** (Ecto.NoResultsError)

  """
  def get_played_hero!(id), do: Repo.get!(PlayedHero, id)

  @doc """
  Creates a played_hero.

  ## Examples

      iex> create_played_hero(%{field: value})
      {:ok, %PlayedHero{}}

      iex> create_played_hero(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_played_hero(attrs \\ %{}) do
    %PlayedHero{}
    |> PlayedHero.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a played_hero.

  ## Examples

      iex> update_played_hero(played_hero, %{field: new_value})
      {:ok, %PlayedHero{}}

      iex> update_played_hero(played_hero, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_played_hero(%PlayedHero{} = played_hero, attrs) do
    played_hero
    |> PlayedHero.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a played_hero.

  ## Examples

      iex> delete_played_hero(played_hero)
      {:ok, %PlayedHero{}}

      iex> delete_played_hero(played_hero)
      {:error, %Ecto.Changeset{}}

  """
  def delete_played_hero(%PlayedHero{} = played_hero) do
    Repo.delete(played_hero)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking played_hero changes.

  ## Examples

      iex> change_played_hero(played_hero)
      %Ecto.Changeset{data: %PlayedHero{}}

  """
  def change_played_hero(%PlayedHero{} = played_hero, attrs \\ %{}) do
    PlayedHero.changeset(played_hero, attrs)
  end

  alias Overstats.Stats.PlayOfTheGame

  @doc """
  Returns the list of plays_of_the_game.

  ## Examples

      iex> list_plays_of_the_game()
      [%PlayOfTheGame{}, ...]

  """
  def list_plays_of_the_game do
    Repo.all(PlayOfTheGame)
  end

  @doc """
  Gets a single play_of_the_game.

  Raises `Ecto.NoResultsError` if the Play of the game does not exist.

  ## Examples

      iex> get_play_of_the_game!(123)
      %PlayOfTheGame{}

      iex> get_play_of_the_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_play_of_the_game!(id), do: Repo.get!(PlayOfTheGame, id)

  @doc """
  Creates a play_of_the_game.

  ## Examples

      iex> create_play_of_the_game(%{field: value})
      {:ok, %PlayOfTheGame{}}

      iex> create_play_of_the_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_play_of_the_game(attrs \\ %{}) do
    %PlayOfTheGame{}
    |> PlayOfTheGame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a play_of_the_game.

  ## Examples

      iex> update_play_of_the_game(play_of_the_game, %{field: new_value})
      {:ok, %PlayOfTheGame{}}

      iex> update_play_of_the_game(play_of_the_game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_play_of_the_game(%PlayOfTheGame{} = play_of_the_game, attrs) do
    play_of_the_game
    |> PlayOfTheGame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a play_of_the_game.

  ## Examples

      iex> delete_play_of_the_game(play_of_the_game)
      {:ok, %PlayOfTheGame{}}

      iex> delete_play_of_the_game(play_of_the_game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_play_of_the_game(%PlayOfTheGame{} = play_of_the_game) do
    Repo.delete(play_of_the_game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking play_of_the_game changes.

  ## Examples

      iex> change_play_of_the_game(play_of_the_game)
      %Ecto.Changeset{data: %PlayOfTheGame{}}

  """
  def change_play_of_the_game(%PlayOfTheGame{} = play_of_the_game, attrs \\ %{}) do
    PlayOfTheGame.changeset(play_of_the_game, attrs)
  end

  alias Overstats.Stats.GameMap

  @doc """
  Returns the list of game_maps.

  ## Examples

      iex> list_game_maps()
      [%GameMap{}, ...]

  """
  def list_game_maps do
    Repo.all(GameMap)
  end

  @doc """
  Gets a single game_map.

  Raises `Ecto.NoResultsError` if the Game map does not exist.

  ## Examples

      iex> get_game_map!(123)
      %GameMap{}

      iex> get_game_map!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_map!(id), do: Repo.get!(GameMap, id)

  @doc """
  Creates a game_map.

  ## Examples

      iex> create_game_map(%{field: value})
      {:ok, %GameMap{}}

      iex> create_game_map(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_map(attrs \\ %{}) do
    %GameMap{}
    |> GameMap.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_map.

  ## Examples

      iex> update_game_map(game_map, %{field: new_value})
      {:ok, %GameMap{}}

      iex> update_game_map(game_map, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_map(%GameMap{} = game_map, attrs) do
    game_map
    |> GameMap.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_map.

  ## Examples

      iex> delete_game_map(game_map)
      {:ok, %GameMap{}}

      iex> delete_game_map(game_map)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_map(%GameMap{} = game_map) do
    Repo.delete(game_map)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_map changes.

  ## Examples

      iex> change_game_map(game_map)
      %Ecto.Changeset{data: %GameMap{}}

  """
  def change_game_map(%GameMap{} = game_map, attrs \\ %{}) do
    GameMap.changeset(game_map, attrs)
  end
end
