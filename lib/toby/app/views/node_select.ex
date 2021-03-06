defmodule Toby.App.Views.NodeSelect do
  @moduledoc """
  Builds a panel for managing the selected Erlang node.
  """

  import Ratatouille.View
  import Ratatouille.Constants, only: [color: 1]

  @style_selected [
    color: color(:black),
    background: color(:white)
  ]

  def render(%{
        data: %{
          current: current,
          cookie: cookie,
          connected_nodes: connected
        },
        cursor_y: cursor
      }) do
    panel(title: "Node Selection (<ESC> to close)", height: :fill) do
      panel(title: "Current") do
        table do
          table_row do
            table_cell(content: "Name")
            table_cell(content: to_string(current))
          end

          table_row do
            table_cell(content: "Cookie")
            table_cell(content: to_string(cookie))
          end
        end
      end

      panel(title: "Select a node... (<ENTER> to select)") do
        table do
          for {node, idx} <- Enum.with_index(connected) do
            table_row(if cursor.position == idx, do: @style_selected, else: []) do
              table_cell(content: to_string(node))
            end
          end
        end
      end
    end
  end

  def render(_) do
    panel(title: "Node Selection (<ESC> to close)", height: :fill) do
      label(content: "Loading...")
    end
  end
end
