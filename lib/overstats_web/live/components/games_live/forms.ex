defmodule OverstatsWeb.GamesLive.Forms do
  use OverstatsWeb, :html

  def game_data_form(assigns) do
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
        <.form_label form={f} field={:role_queue?} />
        <.switch checked={@role_queue?} form={f} field={:role_queue?} />
        <.form_field_error form={f} field={:role_queue?} />
      </div>

      <div class="flex">
        <.form_field
          type="checkbox_group"
          form={f}
          field={:player_names}
          label="Players"
          options={@all_players |> Enum.map(&{&1.name, &1.name})}
        />
      </div>

      <%= if @player_names == [] do %>
        <.button class="submit" label="Continue" />
      <% else %>
        <.button class="submit" label="Reset Players with currently filled" />
      <% end %>
    </.form>
    """
  end

  # For some reason, this library requires that all fields are atoms, so we cannot use
  # dynamically generated fields. Since teams can only have 5 players anyways, we just
  # hard code the 5 fields here. This cannot be refactored any more effectively.
  def player_roles_form(assigns) do
    ~H"""
    <.form
      :let={f}
      for={:player_roles}
      phx-submit="player_roles_submit"
      class="flex flex-col items-start mt-4 gap-y-2"
    >
      <%= if Enum.count(@player_names) > 0 do %>
        <div>
          <.h4 class="mt-2">Player <%= Enum.at(@player_names, 0) %></.h4>
          <.form_field
            type="radio_group"
            form={f}
            field={:player_roles0}
            layout={:row}
            label="Role"
            options={@all_roles |> Enum.map(&{&1, &1})}
          />
        </div>
      <% end %>
      <%= if Enum.count(@player_names) > 1 do %>
        <div>
          <.h4>Player <%= Enum.at(@player_names, 1) %></.h4>
          <.form_field
            type="radio_group"
            form={f}
            field={:player_roles1}
            layout={:row}
            label="Role"
            options={@all_roles |> Enum.map(&{&1, &1})}
          />
        </div>
      <% end %>
      <%= if Enum.count(@player_names) > 2 do %>
        <div>
          <.h4>Player <%= Enum.at(@player_names, 2) %></.h4>
          <.form_field
            type="radio_group"
            form={f}
            field={:player_roles2}
            layout={:row}
            label="Role"
            options={@all_roles |> Enum.map(&{&1, &1})}
          />
        </div>
      <% end %>
      <%= if Enum.count(@player_names) > 3 do %>
        <div>
          <.h4>Player <%= Enum.at(@player_names, 3) %></.h4>
          <.form_field
            type="radio_group"
            form={f}
            field={:player_roles3}
            layout={:row}
            label="Role"
            options={@all_roles |> Enum.map(&{&1, &1})}
          />
        </div>
      <% end %>
      <%= if Enum.count(@player_names) > 4 do %>
        <div>
          <.h4>Player <%= Enum.at(@player_names, 4) %></.h4>
          <.form_field
            type="radio_group"
            form={f}
            field={:player_roles4}
            layout={:row}
            label="Role"
            options={@all_roles |> Enum.map(&{&1, &1})}
          />
        </div>
      <% end %>
      <%= if @player_roles == %{} do %>
        <.button class="submit" label="Continue" />
      <% else %>
        <.button class="submit" label="Reset Roles with currently filled" />
      <% end %>
    </.form>
    """
  end

  def player_heroes_form(assigns) do
    ~H"""
    <.form
      :let={f}
      for={:player_heroes}
      phx-submit="player_heroes_submit"
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
            options={
              if(@role_queue?,
                do:
                  @all_heroes
                  |> heroes_by_role(Map.get(@player_roles, name))
                  |> heroes_to_options(name),
                else: heroes_to_options(@all_heroes, name)
              )
            }
          />
        </div>
      <% end %>

      <%= if @player_heroes == %{} do %>
        <.button class="submit mt-2" label="Continue" />
      <% else %>
        <.button class="submit mt-2" label="Reset Heroes with currently filled" />
      <% end %>
    </.form>
    """
  end

  defp heroes_by_role(heroes, role) do
    Enum.filter(heroes, &(&1.role == role))
  end

  defp heroes_to_options(heroes, player_name) do
    Enum.map(heroes, &{&1.name, "#{&1.name}__#{player_name}"})
  end

  def potg_data_form(assigns) do
    ~H"""
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
        <.button class="submit" label="Create Game" />
      </div>
    </.form>
    """
  end
end
