defmodule OverstatsWeb.PlayersLive do
  use OverstatsWeb, :live_view

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
    <.h1>Players</.h1>
    """
  end
end
