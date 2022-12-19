defmodule OverstatsWeb.GamesLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header
  alias Overstats.{Games, Players, Overwatch}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(game_modes: Games.list_game_modes())
     |> assign(maps: Overwatch.list_maps())
     |> assign(players: [])}
  end

  @impl true
  def handle_event("validate", %{"data" => data}, socket) do
    socket =
      socket |> assign(players: if(is_list(data["players"]), do: data["players"], else: []))

    IO.inspect(socket.assigns.players)
    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", %{"data" => data}, socket) do
    IO.inspect(data)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Header.render page="games" />
    <.container max_width="lg">
      <.h2>Games</.h2>
      <.h3>Recent Games</.h3>

      <.h3>Add New Game</.h3>
      <.form :let={f} for={:data} phx-submit="submit" phx-change="validate">
        <.h4>Game Type</.h4>

        <.form_label form={f} field={:mode} />
        <.select options={assigns.game_modes} form={f} field={:mode} />
        <.form_field_error form={f} field={:mode} />

        <.form_label form={f} field={:map} />
        <.select options={assigns.maps |> Enum.map(& &1.name)} form={f} field={:map} />
        <.form_field_error form={f} field={:map} />

        <.form_label form={f} field={:won?} />
        <.switch form={f} field={:won?} />
        <.form_field_error form={f} field={:won?} />

        <.form_field
          type="checkbox_group"
          form={f}
          field={:players}
          options={Players.list_players() |> Enum.map(&{&1.name, &1.name})}
        />
        <.form_field_error form={f} field={:players} />

        <%= for player <- @players do %>
        <% end %>

        <.h4>Play of the Game (optional)</.h4>
        <.h4>Opposing Team (optional)</.h4>
        <.button class="submit" label="Add Game" />
      </.form>

      <.h3>Game History</.h3>
    </.container>
    """
  end
end
