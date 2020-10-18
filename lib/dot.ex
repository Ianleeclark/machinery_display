defmodule MachineryDisplay.Dot do
  @moduledoc """
  A graphviz setup for displaying Machinery states.
  """

  @doc """
  Converts a state machine module to a string representing the
  state machine.
  """
  @spec create_output(state_machine :: module()) :: String.t()
  def create_output(state_machine), do: state_machine_to_dot(state_machine)

  @doc """
  Helper function to provide the extension
  """
  @spec file_extension :: String.t()
  def file_extension, do: "dot"

  #####################
  # Private Functions #
  #####################

  @spec state_machine_to_dot(state_machine :: module()) :: String.t()
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
