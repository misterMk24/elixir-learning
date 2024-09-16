defmodule Calc do
  @moduledoc """
  Simple Calculator implementation with User input.

  Usage example:
      Calc.loop()
        Enter your expression:
        1+2
        Result: 3.0

        Enter your expression:
        exit
        See you!
  """
  @spec loop() :: :ok
  def loop do
    input = IO.gets("Enter your expression:\n") |> String.trim()
    with {:ok, _} <- Helpers.exit_command?(input),
         {:ok, parsed_input} <- Helpers.parse_input(input),
         {:ok, {var1, operator, var2}} <- Helpers.convert_data(parsed_input),
         {:ok, result} <- calculate(operator, var1, var2) do
           IO.puts("Result: " <> inspect(result) <> "\n")
           loop()
    else
      {:error, message} ->
        IO.puts(message)
        loop()

      {:exit, exit_message} -> IO.puts(exit_message)
    end
  end

  @valid_operators [:+, :-, :*, :/]
  @spec calculate(any(), any(), any()) :: {:error, String.t()}
  defp calculate(operator, _, _) when operator not in @valid_operators, do: {:error, "invalid operator"}

  @spec calculate(:+, number(), number()) :: {:ok, float()}
  defp calculate(:+, var1, var2), do: {:ok, var1 + var2}

  @spec calculate(:-, number(), number()) :: {:ok, float()}
  defp calculate(:-, var1, var2), do: {:ok, var1 - var2}

  @spec calculate(:*, number(), number()) :: {:ok, float()}
  defp calculate(:*, var1, var2), do: {:ok, var1 * var2}

  @spec calculate(:/, number(), 0) :: {:error, String.t()}
  defp calculate(:/, _, var2) when var2 == 0, do: {:error, "you cannot divide by 0"}
  defp calculate(:/, var1, var2), do: {:ok, var1 / var2}
end
