defmodule MachineryDisplay.DotTest do
  use ExUnit.Case
  alias MachineryDisplay.Dot

  defmodule MachineryDisplay.CyclicStateMachine do
    use Machinery,
      field: :state,
      states: ["initial", "middle", "complete"],
      transitions: %{
        "initial" => ["middle", "complete"],
        "middle" => ["complete"],
        "complete" => "initial"
      }
  end

  defmodule MachineryDisplay.AcyclicStateMachine do
    use Machinery,
      field: :state,
      states: ["initial", "middle", "complete"],
      transitions: %{
        "initial" => ["middle", "complete"],
        "middle" => ["complete"]
      }
  end

  describe "create_output/1" do
    test "Handles cyclic graphs" do
      assert Dot.create_output(MachineryDisplay.CyclicStateMachine) ==
               "digraph X { complete -> initial;initial -> middle;initial -> complete;middle -> complete; }"
    end

    test "Handles acyclic graphs" do
      assert Dot.create_output(MachineryDisplay.AcyclicStateMachine) ==
               "digraph X { initial -> middle;initial -> complete;middle -> complete; }"
    end
  end

  describe "file_extension/0" do
    test "Smoke test to ensure it returns `dot`" do
      assert Dot.file_extension() == "dot"
    end
  end
end
