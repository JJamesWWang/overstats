defmodule OverstatsWeb.Header do
  use OverstatsWeb, :html

  defp header_item(assigns) do
    ~H"""
    <%= if @current_page? do %>
      <span class="text-primary-600 dark:text-primary-400 text-xl font-bold">
        <%= @label %>
      </span>
    <% else %>
      <.a link_type="live_redirect" to={@to}>
        <span class="text-gray-600 dark:text-gray-400 hover:text-secondary-600 dark:hover:text-secondary-400 text-xl font-bold">
          <%= @label %>
        </span>
      </.a>
    <% end %>
    """
  end

  def render(assigns) do
    games? = assigns[:page] == "games"
    players? = assigns[:page] == "players"
    stats? = assigns[:page] == "stats"

    ~H"""
    <.container max_width="lg">
      <nav class="sticky flex items-center justify-between w-full h-16 bg-white dark:bg-gray-900 my-6">
        <div class="flex">
          <span class="text-primary-600 dark:text-primary-400 text-3xl font-bold">Over</span>
          <span class="text-secondary-600 dark:text-secondary-400 text-3xl font-bold">stats</span>
          <div class="ml-2">
            <.color_scheme_switch />
          </div>
        </div>
        <div class="flex flex-1 justify-between items-center">
          <div />
          <.header_item current_page?={games?} to={~p"/games/index"} label="Games" />
          <.header_item current_page?={players?} to={~p"/players/index"} label="Players" />
          <.header_item current_page?={stats?} to={~p"/stats"} label="Stats" />
          <div />
        </div>
      </nav>
    </.container>
    """
  end
end
