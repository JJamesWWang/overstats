defmodule OverstatsWeb.GamesLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header
  alias Overstats.{Games, Players, Overwatch}
  import OverstatsWeb.GamesLive.Forms

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(all_game_modes: Games.list_game_modes())
     |> assign(all_maps: Overwatch.list_maps())
     |> assign(all_players: Players.list_players())
     |> assign(all_heroes: Overwatch.list_heroes())
     |> assign(all_roles: Overwatch.list_roles())
     # list of player names
     |> assign(roles?: true)
     |> assign(player_names: [])
     |> assign(player_roles: %{})
     # map from player name to list of heroes played
     |> assign(player_heroes: %{})
     |> assign(potg_player: nil)}
  end

  @impl true
  def handle_event(
        "game_data_submit",
        %{"game_data" => %{"player_names" => player_names, "roles?" => roles?}},
        socket
      ) do
    {:noreply,
     socket
     |> assign(roles?: roles? == "true")
     |> assign(player_names: if(is_list(player_names), do: player_names, else: []))
     |> assign(player_heroes: %{})}
  end

  def handle_event(
        "player_roles_submit",
        %{"player_roles" => data},
        %{assigns: %{player_names: player_names}} = socket
      ) do
    roles = map_player_to_roles(player_names, data)
    all_selected? = Map.values(roles) |> Enum.all?(&(&1 != nil))
    valid_selection? = all_selected? and roles_violate_count?(roles)

    IO.puts(all_selected?)
    IO.puts(valid_selection?)
    IO.inspect(roles)

    cond do
      not all_selected? ->
        {:noreply,
         socket
         |> assign(player_roles: %{})
         |> put_flash(:error, "Please select a role for each player.")}

      not valid_selection? ->
        {:noreply,
         socket
         |> assign(player_roles: %{})
         |> put_flash(
           :error,
           "Please select a roles according to role queue (1 Tank, 2 Damage, 2 Support)."
         )}

      true ->
        {:noreply, socket |> assign(player_roles: map_player_to_roles(player_names, data))}
    end
  end

  def handle_event("player_roles_submit", _params, socket) do
    {:noreply,
     socket
     |> assign(player_roles: %{})
     |> put_flash(:error, "Please select a role for each player.")}
  end

  def handle_event(
        "player_heroes_submit",
        %{"player_heroes" => %{"player_heroes" => player_heroes}},
        %{assigns: %{player_names: player_names}} = socket
      ) do
    {:noreply,
     socket
     |> assign(
       player_heroes:
         if(is_list(player_heroes), do: player_heroes |> map_player_to_heroes(), else: %{})
     )
     |> assign(potg_player: if(is_list(player_heroes), do: List.first(player_names), else: nil))}
  end

  def handle_event("potg_data_change", %{"potg_data" => %{"potg_player" => potg_player}}, socket) do
    {:noreply, socket |> assign(potg_player: potg_player)}
  end

  def handle_event("potg_skip", _params, socket) do
    {:noreply, socket |> assign(potg_player: nil)}
  end

  def handle_event(
        "potg_data_submit",
        %{"potg_data" => %{"potg_hero" => potg_hero}},
        socket
      ) do
    {:noreply, socket}
  end

  defp map_player_to_roles(player_names, roles_map) do
    player_names
    |> Enum.with_index()
    |> Map.new(fn {name, i} -> {name, roles_map["player_roles#{i}"]} end)
  end

  defp map_player_to_heroes(player_heroes) do
    player_heroes
    |> Enum.map(fn s -> String.split(s, "__") end)
    |> Enum.reduce(%{}, fn [hero | player_name], acc ->
      Map.update(acc, player_name |> Enum.join(), [hero], fn existing -> [hero | existing] end)
    end)
  end

  defp roles_violate_count?(roles) do
    roles
    |> Map.values()
    |> Enum.frequencies()
    |> Enum.all?(fn {role, count} ->
      case role do
        "Tank" -> count <= 1
        "Damage" -> count <= 2
        "Support" -> count <= 2
      end
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Header.render page="games" />
    <.container max_width="lg">
      <.h2>Games</.h2>
      <.h3>Recent Games</.h3>

      <.h3>Add New Game</.h3>
      <.game_data_form
        all_game_modes={@all_game_modes}
        all_maps={@all_maps}
        all_players={@all_players}
        roles?={@roles?}
        player_names={@player_names}
      />

      <%= if @roles? and @player_names != [] do %>
        <.player_roles_form all_roles={@all_roles} player_names={@player_names} />
      <% end %>

      <%= if @player_names != [] and (not @roles? or @player_roles != %{}) do %>
        <.player_heroes_form
          all_heroes={@all_heroes}
          roles?={@roles?}
          player_names={@player_names}
          player_roles={@player_roles}
        />
      <% end %>

      <%= if @player_heroes != %{} do %>
        <.potg_data_form
          all_heroes={@all_heroes}
          player_names={@player_names}
          player_heroes={@player_heroes}
          potg_player={@potg_player}
        />
      <% end %>

      <%!-- <.h4>Opposing Team (optional)</.h4>
          <.form_field
            type="checkbox_group"
            layout={:row}
            form={f}
            field={:opponents_played_heroes}
            options={@all_heroes |> Enum.map(&{&1.name, &1.name})}
          /> --%>

      <.h3 class="mt-4">Game History</.h3>
    </.container>
    """
  end
end
