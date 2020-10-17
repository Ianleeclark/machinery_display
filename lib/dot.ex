defmodule MachineryDisplay.Dot do
  @moduledoc """
  A graphviz setup for displaying Machinery states.
  """

  def state_machine_to_dot(state_machine) do
    transitions =
      state_machine._machinery_transitions
      |> Enum.flat_map(fn
        {state, transitions} when is_list(transitions) ->
          transitions
          |> Enum.map(fn end_state ->
            transition_to_string(state, end_state)
          end)

        {state, end_state} ->
          [transition_to_string(state, end_state)]
      end)

    transitions
  end

  defp transition_to_string(initial_state, end_state)
       when is_binary(initial_state) and is_binary(end_state) do
    "#{initial_state} -> #{end_state};"
  end

  defp dot_header(name), do: "digraph #{name} {"

  defp dot_footer(), do: "}"
end
