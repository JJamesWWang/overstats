defmodule OverstatsWeb.GamesLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header
  alias Overstats.{Games, Players, Overwatch}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(all_game_modes: Games.list_game_modes())
     |> assign(all_maps: Overwatch.list_maps())
     |> assign(all_players: Players.list_players())
     |> assign(all_heroes: Overwatch.list_heroes())
     # list of player names
     |> assign(player_names: [])
     # map from player name to list of heroes played
     |> assign(player_heroes: %{})
     |> assign(potg_player: nil)}
  end

  @impl true
  def handle_event(
        "game_data_submit",
        %{"game_data" => %{"player_names" => player_names}},
        socket
      ) do
    {:noreply,
     socket
     |> assign(player_names: if(is_list(player_names), do: player_names, else: []))
     |> assign(player_heroes: %{})}
  end

  def handle_event(
        "player_data_submit",
        %{"player_data" => %{"player_heroes" => player_heroes}},
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

  defp map_player_to_heroes(player_heroes) do
    player_heroes
    |> Enum.map(fn s -> String.split(s, "_") end)
    |> Enum.reduce(%{}, fn [player_name | hero], acc ->
      Map.update(acc, player_name, hero, fn existing -> hero ++ existing end)
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
        player_names={@player_names}
      />

      <.player_data_form all_heroes={@all_heroes} player_names={@player_names} />

      <.potg_data_form
        all_heroes={@all_heroes}
        player_names={@player_names}
        player_heroes={@player_heroes}
        potg_player={@potg_player}
      />

      <%!-- <.h4>Opposing Team (optional)</.h4>
          <.form_field
            type="checkbox_group"
            layout={:row}
            form={f}
            field={:opponents_played_heroes}
            options={@all_heroes |> Enum.map(&{&1.name, &1.name})}
          /> --%>

      <.h3 class="mt-3">Game History</.h3>
    </.container>
    """
  end

  defp game_data_form(assigns) do
    ~H"""
    <.form
      :let={f}
      for={:game_data}
      phx-submit="game_data_submit"
      class="flex flex-col gap-y-2 items-start"
    >
      <.h4 class="mt-3">Game Type</.h4>

      <div>
        <.form_label form={f} field={:mode} />
        <.select options={@all_game_modes} form={f} field={:mode} />
        <.form_field_error form={f} field={:mode} />
      </div>

      <div>
        <.form_label form={f} field={:map} />
        <.select options={@all_maps |> Enum.map(& &1.name)} form={f} field={:map} />
        <.form_field_error form={f} field={:map} />
      </div>

      <div>
        <.form_label form={f} field={:won?} />
        <.switch form={f} field={:won?} />
        <.form_field_error form={f} field={:won?} />
      </div>

      <div>
        <.form_label form={f} field={:roles?} />
        <.switch checked form={f} field={:roles?} />
        <.form_field_error form={f} field={:roles?} />
      </div>

      <.form_field
        type="checkbox_group"
        form={f}
        field={:player_names}
        options={@all_players |> Enum.map(&{&1.name, &1.name})}
      />

      <%= if @player_names == [] do %>
        <.button class="submit" label="Continue" />
      <% else %>
        <.button class="submit" label="Reset Players with currently filled" />
      <% end %>
    </.form>
    """
  end

  defp player_data_form(assigns) do
    ~H"""
    <%= if @player_names != [] do %>
      <.form
        :let={f}
        for={:player_data}
        phx-submit="player_data_submit"
        class="flex flex-col items-start mt-4 gap-y-4"
      >
        <%= for name <- @player_names do %>
          <div class="w-full overflow-x-auto">
            <.h3>Player <%= name %></.h3>
            <.form_field
              type="checkbox_group"
              layout={:row}
              form={f}
              field={:player_heroes}
              options={@all_heroes |> Enum.map(&{&1.name, "#{name}_#{&1.name}"})}
            />
          </div>
        <% end %>

        <.button class="submit mt-4" label="Continue" />
      </.form>
    <% end %>
    """
  end

  defp potg_data_form(assigns) do
    ~H"""
    <%= if @player_heroes != %{} do %>
      <.form
        :let={f}
        for={:potg_data}
        phx-change="potg_data_change"
        phx-submit="potg_data_submit"
        class="flex flex-col mt-4 gap-y-4"
      >
        <.h4>Play of the Game (optional)</.h4>

        <.form_label form={f} field={:potg_player} label="Player of the Game" />
        <.select options={@player_names} form={f} field={:potg_player} />
        <.form_field_error form={f} field={:potg_player} />

        <.form_label form={f} field={:potg_hero} label="Hero Played" />
        <.select options={Map.get(@player_heroes, @potg_player)} form={f} field={:potg_hero} />
        <.form_field_error form={f} field={:potg_hero} />

        <div class="flex gap-x-4 mt-4">
          <.button class="" label="Skip" phx-click="potg_skip" color="gray" />
          <.button class="submit" label="Continue" />
        </div>
      </.form>
    <% end %>
    """
  end
end
