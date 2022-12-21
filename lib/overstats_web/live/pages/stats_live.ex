defmodule OverstatsWeb.StatsLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header
  alias Overstats.Players

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(all_players: Players.list_players())
     |> push_event("stats_data_updated", %{data: %{name: "Default"}})}
  end

  @impl true
  def handle_event(
        "stats_data_submit",
        %{"stats_data" => %{"player_name" => player_name}},
        socket
      ) do
    player = Players.get_player_by_name!(player_name)
    {:noreply, socket |> push_event("stats_data_updated", %{data: %{name: player.name}})}
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

        <.button class="submit" label="Continue" />
      </.form>

      <div id="stats-hook" phx-hook="StatsHook" />
    </.container>
    """
  end
end
