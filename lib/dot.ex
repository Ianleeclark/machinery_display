defmodule MachineryDisplay.Dot do
  @moduledoc """
  A graphviz setup for displaying Machinery states.
  """

  @spec create_output(state_machine :: Module.t()) :: String.t()
  def create_output(state_machine), do: state_machine_to_dot(state_machine)

  def file_extension, do: "dot"

  #####################
  # Private Functions #
  #####################

  @spec state_machine_to_dot(state_machine :: Module.t()) :: String.t()
  defp state_machine_to_dot(state_machine) do
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

    "digraph X { #{transitions |> Enum.join()} }"
  end

  @spec transition_to_string(initial_state :: String.t(), end_state :: String.t()) :: String.t()
  defp transition_to_string(initial_state, end_state)
       when is_binary(initial_state) and is_binary(end_state) do
    "#{initial_state} -> #{end_state};"
  end
end
