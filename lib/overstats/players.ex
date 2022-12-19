defmodule Overstats.Players do
  @moduledoc """
  The Players context.
  """

  import Ecto.Query, warn: false
  alias Overstats.Repo

  alias Overstats.Players.Player

  @doc """
  Returns the list of players, excluding the 'Random' player.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
    |> Enum.reject(&(&1.name == "Random"))
  end

  @doc """
  Gets a single player.

  ## Examples
        iex> get_player(123)
        {:ok, %Player{}}

        iex> get_player(456)
        {:error, %Ecto.Changeset{}}
  """
  def get_player(id), do: Repo.get(Player, id)

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    if player.name == "Random" do
      {:error, "Cannot delete the 'Random' player"}
    else
      Repo.delete(player)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end

  @doc """
  Returns an empty %Player{} struct.

  ## Examples

      iex> new_player()
      %Player{}
  """
  def new_player() do
    %Player{}
  end
end
