defmodule OverstatsWeb.StatsLive do
  use OverstatsWeb, :live_view
  alias OverstatsWeb.Header

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Header.render page="stats" />
    <.container max_width="lg">
      <.h2>Stats</.h2>
      <div id="stats-hook" phx-hook="StatsHook" data-stats={["hello"]} />
    </.container>
    """
  end
end
