defmodule MachineryDisplay.MixProject do
  use Mix.Project

  def project do
    [
      app: :machinery_display,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      aliases: aliases(),
      # Make sure that test commands always run in `:test`
      preferred_cli_env: [testall: :test, test: :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      testall: ["credo", "test"]
    ]
  end

  defp deps do
    [
      {:machinery, ">= 1.0.0"},
      # Non-core dependencies
      {:ex_doc, "~> 0.19", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Generates graphs from Machinery state machines."
  end

  defp package do
    [
      name: "machinery_display",
      files: ["lib", "mix.exs", "README.*", "LICENSE"],
      maintainers: ["Ian Lee Clark"],
      licenses: ["BSD"],
      links: %{"Github" => "https://github.com/ianleeclark/machinery_display"}
    ]
  end
end
