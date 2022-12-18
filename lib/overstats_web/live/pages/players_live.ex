defmodule OverstatsWeb.PlayersLive do
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
    <Header.render page="players" />
    <.container max_width="lg">
      <.h2>Players</.h2>
    </.container>
    """
  end
end