defmodule Overstats.Overwatch do
  @moduledoc """
  The Overwatch context.
  """

  import Ecto.Query, warn: false
  alias Overstats.Repo

  alias Overstats.Overwatch.Hero

  @doc """
  Returns the list of heroes.

  ## Examples

      iex> list_heroes()
      [%Hero{}, ...]

  """
  def list_heroes do
    Repo.all(Hero)
  end

  @doc """
  Returns all unique roles for heroes.

  ## Examples

      iex> list_roles()
      ["Tank", "Damage", "Support"]
  """
  def list_roles do
    Repo.all(Hero)
    |> Enum.map(& &1.role)
    |> Enum.uniq()
  end

  @doc """
  Gets a single hero.

  Raises `Ecto.NoResultsError` if the Hero does not exist.

  ## Examples

      iex> get_hero!(123)
      %Hero{}

      iex> get_hero!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hero!(id), do: Repo.get!(Hero, id)

  @doc """
  Gets a single hero by name.

  Raises `Ecto.NoResultsError` if the Hero does not exist.

  ## Examples

      iex> get_hero_by_name!("Reaper")
      %Hero{}

      iex> get_hero_by_name!("Reaper")
      ** (Ecto.NoResultsError)

  """
  def get_hero_by_name!(name), do: Repo.get_by!(Hero, name: name)

  @doc """
  Creates a hero.

  ## Examples

      iex> create_hero(%{field: value})
      {:ok, %Hero{}}

      iex> create_hero(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hero(attrs \\ %{}) do
    %Hero{}
    |> Hero.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hero.

  ## Examples

      iex> update_hero(hero, %{field: new_value})
      {:ok, %Hero{}}

      iex> update_hero(hero, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hero(%Hero{} = hero, attrs) do
    hero
    |> Hero.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hero.

  ## Examples

      iex> delete_hero(hero)
      {:ok, %Hero{}}

      iex> delete_hero(hero)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hero(%Hero{} = hero) do
    Repo.delete(hero)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hero changes.

  ## Examples

      iex> change_hero(hero)
      %Ecto.Changeset{data: %Hero{}}

  """
  def change_hero(%Hero{} = hero, attrs \\ %{}) do
    Hero.changeset(hero, attrs)
  end

  alias Overstats.Overwatch.Map

  @doc """
  Returns the list of maps.

  ## Examples

      iex> list_maps()
      [%Map{}, ...]

  """
  def list_maps do
    Repo.all(Map)
  end

  @doc """
  Gets a single map.

  Raises `Ecto.NoResultsError` if the Map does not exist.

  ## Examples

      iex> get_map!(123)
      %Map{}

      iex> get_map!(456)
      ** (Ecto.NoResultsError)

  """
  def get_map!(id), do: Repo.get!(Map, id)

  @doc """
  Gets a single map by name.

  Raises `Ecto.NoResultsError` if the Map does not exist.

  ## Examples

      iex> get_map_by_name!("Hanamura")
      %Map{}

      iex> get_map_by_name!("Hanamura")
      ** (Ecto.NoResultsError)
  """
  def get_map_by_name!(name), do: Repo.get_by!(Map, name: name)

  @doc """
  Creates a map.

  ## Examples

      iex> create_map(%{field: value})
      {:ok, %Map{}}

      iex> create_map(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_map(attrs \\ %{}) do
    %Map{}
    |> Map.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a map.

  ## Examples

      iex> update_map(map, %{field: new_value})
      {:ok, %Map{}}

      iex> update_map(map, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_map(%Map{} = map, attrs) do
    map
    |> Map.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a map.

  ## Examples

      iex> delete_map(map)
      {:ok, %Map{}}

      iex> delete_map(map)
      {:error, %Ecto.Changeset{}}

  """
  def delete_map(%Map{} = map) do
    Repo.delete(map)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking map changes.

  ## Examples

      iex> change_map(map)
      %Ecto.Changeset{data: %Map{}}

  """
  def change_map(%Map{} = map, attrs \\ %{}) do
    Map.changeset(map, attrs)
  end
end
