defmodule MachineryDisplay.SimpleTestStateMachine do
  use Machinery,
    field: :state,
    states: ["initial", "middle", "complete"],
    transitions: %{
      "initial" => ["middle", "complete"],
      "middle" => ["complete"],
      "complete" => "initial"
    }
end
