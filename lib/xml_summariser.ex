# TODO: port to xmerl_sax_handler to reduce external dependencies
# NOTE: for much larger docs later, this is the way https://github.com/qcam/saxy/pull/100
defmodule Sax.Handlers.XmlSummariser do
  @moduledoc """
  A `Saxy` handler useful to provide a textual résumé of a XML.
  """
  @behaviour Saxy.Handler

  def format_line([item]), do: item
  def format_line(items = [item | _tail]), do: "#{item} (x#{items |> length})"

  def handle_event(:start_document, _options, []) do
    {:ok, %{level: 0, output: []}}
  end

  def handle_event(:end_document, _options, state) do
    output =
      state.output
      |> Enum.chunk_by(& &1)
      |> Enum.map(&format_line(&1))
      |> Enum.join("\n")

    {:ok, output}
  end

  def handle_event(:start_element, {name, _attributes}, state) do
    indent = String.duplicate("  ", state.level)

    state =
      state
      |> Map.update!(:level, &(&1 + 1))

    state =
      state
      |> Map.update!(:output, fn output ->
        # TODO: support customisation
        cond do
          state.level > 5 -> output
          state.level in 2..3 -> output ++ [indent <> "(...)"]
          true -> output ++ [indent <> name]
        end
      end)

    {:ok, state}
  end

  def handle_event(:end_element, _, state) do
    state = state |> Map.update!(:level, &(&1 - 1))
    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}
end
