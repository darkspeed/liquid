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
    Mix.shell().info(IO.ANSI.format([:blue, "Liquid Proxy ", :reset, "v#{Application.spec(:liquid, :vsn)}"]))
    Mix.shell().info(Application.spec(:liquid, :description))
    Mix.shell().info([IO.ANSI.bright(), "Availible tasks:"])
    Mix.Tasks.Help.run(["--search", "liq."])
  end
end
