defmodule MachineryDisplayTest do
  use ExUnit.Case

  defmodule MachineryDisplay.TestStateMachine do
    use Machinery,
      field: :state,
      states: ["initial", "middle", "complete"],
      transitions: %{
        "initial" => ["middle", "complete"],
        "middle" => ["complete"],
        "complete" => "initial"
      }
  end
end
