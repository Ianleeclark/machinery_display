defmodule MachineryDisplayTest do
  use ExUnit.Case

  alias MachineryDisplay

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
