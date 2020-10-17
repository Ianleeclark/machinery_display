defmodule Mix.Tasks.MachineryDisplay do
  @moduledoc """
  Generates outputs for all applications provided.
  """
  use Mix.Task

  @shortdoc "Generates diagrams of Machinery state machines."
  def run([applications]) when is_list(applications) do
    application_atoms = applications |> Enum.map(&String.to_atom/1)

    applications_loaded_okay? = application_atoms
    |> Enum.map(fn x -> :application.load(x) end)
    |> Enum.all?()

    if not applications_loaded_okay? do
      System.stop(1)
    end

    MachineryDisplay.generate_all_outputs(:machinery_display)
  end

  def run([application]) when is_binary(application) do
    application_atom = String.to_atom(application)
    with :ok <- :application.load(application_atom) do
      MachineryDisplay.generate_all_outputs(application_atom)
    end
  end
end
