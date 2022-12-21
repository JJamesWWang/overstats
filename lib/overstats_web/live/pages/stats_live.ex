defmodule OverstatsWeb.StatsLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header
  alias Overstats.Players
  alias Overstats.Queries

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(all_players: Players.list_players())
     |> assign(player_name: nil)
     |> push_event("stats_data_updated", %{data: Queries.get_all_stats()})}
  end

  @impl true
  def handle_params(%{"player" => player_name}, _uri, socket) do
    player = Players.get_player_by_name!(player_name)

    {:noreply,
     socket
     |> assign(player_name: player_name)
     |> push_event("stats_data_updated", %{data: Queries.get_player_stats(player)})}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "stats_data_submit",
        %{"stats_data" => %{"player_name" => player_name}},
        socket
      ) do
    {:noreply, socket |> push_redirect(to: ~p"/stats?player=#{player_name}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Header.render page="stats" />
    <.container max_width="lg">
      <.h2>Stats</.h2>
      <.form
        :let={f}
        for={:stats_data}
        phx-submit="stats_data_submit"
        class="flex flex-col gap-y-3 items-start"
      >
        <.h3>Choose a player</.h3>

        <div>
          <.form_label form={f} field={:player_name} />
          <.select
            options={@all_players |> Enum.map(&{&1.name, &1.name})}
            form={f}
            field={:player_name}
          />
          <.form_field_error form={f} field={:player_name} />
        </div>

        <.button class="submit" label="Show stats for player" />
      </.form>

      <.h3 class="mt-4">
        Statistics (<%= if(is_nil(@player_name), do: "All", else: @player_name) %>)
      </.h3>
      <div class="mt-4" id="stats-hook" phx-hook="StatsHook" />
    </.container>
    """
  end
end
