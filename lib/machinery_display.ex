defmodule MachineryDisplay do
  @moduledoc """
  Documentation for MachineryDisplay.
  """

  alias MachineryDisplay.Dot

  @doc """
  Handles generating outputs for every Machinery state machine encountered
  in the system.
  """
  @spec generate_all_outputs(atom()) :: [] | {:error, :no_state_machines_found}
  def generate_all_outputs(application_name) when is_atom(application_name) do
    case :application.get_key(application_name, :modules) do
      {:ok, modules} ->
        modules
        |> Enum.filter(fn x ->
          Kernel.function_exported?(x, :_machinery_states, 0)
        end)
        |> Enum.map(&generate_for_module/1)

      _ ->
        {:error, :no_state_machines_found}
    end
  end

  @doc """
  Handles generating an output for a single state machine.
  """
  @spec generate_for_module(module :: Module.t()) :: :ok | {:error, atom(), map()}
  def generate_for_module(module) do
    module
    |> generate_outputs()
    |> Enum.map(fn {type, output} ->
      file_name = "#{module.__info__(:module)}.#{file_extension_for_output_type(type)}"

      with {:ok, file_path} <- write_to_file(file_name, output),
           :ok <- compile_file(type, file_path) do
        :ok
      end
    end)
  end

  #####################
  # Private Functions #
  #####################

  @spec generate_outputs(state_machine :: Module.t()) :: map()
  defp generate_outputs(state_machine) do
    %{dot: Dot.create_output(state_machine)}
  end

  @spec write_to_file(file_name :: String.t(), output :: String.t()) ::
          {:ok, Path.t()} | {:error, :compilation_error, map()}
  defp write_to_file(file_name, output) do
    root_dir = File.cwd!()
    output_file = Path.join(root_dir, file_name)
    case File.write(output_file, output) do
      :ok ->
        {:ok, output_file}

      error ->
        {:error, :compilation_error, %{output_file: output_file, output: output, error: error}}
    end
  end

  @spec compile_file(:dot | atom(), file_name :: String.t()) :: :ok | {:error, :compilation_error, map()}
  defp compile_file(:dot, file_name) do
    with {"", 0} <- System.cmd("dot", ["-Tpng", file_name, "-o", String.replace(file_name, ".dot", ".png")]) do
      :ok
    else
      {msg, retval} -> {:error, :compilation_error, %{error_message: msg, retval: retval}}
    end
  end

  defp compile_file(type, file_name) do
    {:error, :unsupported_file_type}
  end

  @spec file_extension_for_output_type(type :: atom()) :: Strimg.t()
  defp file_extension_for_output_type(type) do
    case type do
      :dot -> Dot.file_extension()
    end
  end
end
