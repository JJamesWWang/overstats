defmodule OverstatsWeb.PlayersLive do
  use OverstatsWeb, :live_view
  alias Overstats.Players
  alias OverstatsWeb.Header

  @impl true
  def mount(_params, _session, socket) do
    players = Players.list_players()

    {:ok,
     socket
     |> assign(players: players)
     |> assign(changeset: Players.change_player(Players.new_player()))}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    case socket.assigns.live_action do
      :index ->
        {:noreply, socket |> assign(delete: nil)}

      :delete ->
        {:noreply, socket |> assign(delete: Players.get_player(params["id"]))}
    end
  end

  @impl true
  def handle_event("submit", %{"player" => %{"name" => name}}, socket) do
    case Players.create_player(%{name: name}) do
      {:ok, _player} ->
        {:noreply,
         socket
         |> assign(players: Players.list_players())
         |> assign(changeset: Players.change_player(Players.new_player()))}

      {:error, changeset} ->
        {:noreply, socket |> assign(changeset: changeset)}
    end
  end

  def handle_event("delete", _params, %{assigns: %{delete: player}} = socket) do
    socket = case Players.delete_player(player) do
      {:ok, _player} ->
        assign(socket, players: Players.list_players())

      {:error, changeset} ->
        assign(socket, changeset: changeset)
    end
    {:noreply, push_patch(socket, to: ~p"/players")}
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply, socket |> assign(delete: nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Header.render page="players" />
    <.container max_width="lg">
      <.h2>Players</.h2>
      <.h3 class="mt-6">Add Player</.h3>
      <.form :let={f} for={@changeset} phx-submit="submit">
        <div class="flex gap-4 my-4">
          <div class="flex-1">
            <.form_label form={f} field={:name} />
            <.text_input form={f} field={:name} />
            <.form_field_error form={f} field={:name} />
          </div>
          <div class="flex flex-col justify-end">
            <.button class="submit" label="Add Player" />
          </div>
        </div>
      </.form>
      <.h3>All Players</.h3>
      <div class="flex flex-col">
        <%= for player <- @players do %>
          <div class="flex align-center">
            <.a
              to={~p"/stats?player=#{player.name}"}
              link_type="live_redirect"
              class="flex items-center"
            >
              <span class="text-secondary-700 dark:text-secondary-400 hover:text-secondary-900 dark:hover:text-secondary-200 text-xl font-medium">
                <%= player.name %>
              </span>
            </.a>
            <.icon_button to={~p"/players/delete/#{player.id}"} link_type="live_patch" class="ml-4">
              <Heroicons.trash />
            </.icon_button>
          </div>
        <% end %>
      </div>
    </.container>

    <%= if @delete do %>
      <.modal title={"Are you sure you want to delete #{@delete.name}?"}>
        <.p>This will delete all stats associated with this player.</.p>
        <div class="flex justify-between mt-6">
          <div />
          <.button link_type="live_patch" to={~p"/players"} label="Cancel" color="gray" />
          <.button label="Delete" color="danger" phx-click="delete" />
          <div />
        </div>
      </.modal>
    <% end %>
    """
  end
end
