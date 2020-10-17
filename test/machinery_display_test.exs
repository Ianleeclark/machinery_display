defmodule MachineryDisplayTest do
  use ExUnit.Case
  doctest MachineryDisplay

  defmodule TestStateMachine do
    use Machinery,
      field: :state,
      states: ["initial", "middle", "complete"],
      transitions: %{
        "initial" => ["middle", "complete"],
        "middle" => ["complete"],
        "complete" => "initial"
      }
  end

  test "greets the world" do
    assert MachineryDisplay.hello() == :world
  end
end
