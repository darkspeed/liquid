defmodule Mix.Tasks.Liq do
  use Mix.Task

  @shortdoc "Display Liquid usage information"

  @moduledoc """
  Displays Liquid tasks and their usage instructions
  """

  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Unexpected arguments. Did you mean to use a task?"
    end
  end

  defp general() do
    Application.ensure_all_started(:liquid)
    Mix.shell().info("Liquid Proxy v#{Application.spec(:liquid, :vsn)}")
    Mix.shell().info(Application.spec(:liquid, :description))
  end
end
