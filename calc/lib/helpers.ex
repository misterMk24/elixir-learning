defmodule Helpers do
  @moduledoc """
  Helpers module for parsing and converting data purposes
  """

  @doc """
  Initial User input parsing with regular expression

  ## Examples
      iex> Helpers.parse_input("1+2")
      {:ok, {"1", "+", "2"}}
  """
  @spec parse_input(String.t()) :: {:ok, tuple()} | {:error, String.t()}
  def parse_input(input) do
    ~r{[-]?\d+(?:\.\d+)?|[+*/-]|\w+}
    |> Regex.scan(input, capture: :first)
    |> case do
      [[num1], [sign], [num2]] -> {:ok, {num1, sign, num2}}
      _ -> {:error, "incorrect input has been provided"}
    end
  end

  @doc """
  Convert User input data to Float

  ## Examples
      iex> Helpers.convert_data({"1", "*", "2"})
      {:ok, {1.0, :*, 2.0}}
  """
  @spec convert_data(tuple()) :: {:ok, tuple()} | {:error, String.t()}
  def convert_data({var1, operator, var2}) do
    with {:ok, var1} <- convert_to_float(var1),
         {:ok, var2} <- convert_to_float(var2),
         {:ok, operator} <- convert_to_atom(operator) do
      {:ok, {var1, operator, var2}}
    else
      {:error, message} -> {:error, message}
    end
  end

  @doc """
  Convert User input data to Float

  ## Examples
      iex> Helpers.exit_command?("exit")
      {:exit, "See you!"}
  """
  @spec exit_command?(String.t()) :: {:exit, String.t()} | {:ok, String.t()}
  def exit_command?(input) do
    case input do
      "exit" -> {:exit, "See you!"}
      _ -> {:ok, "proceed further"}
    end
  end

  defp convert_to_float(var) do
    case Float.parse(String.trim(var)) do
      {var, ""} -> {:ok, var}
      {var, _trailing_garbage} -> {:error, "trailing garbage in ‹#{var}›"}
      :error -> {:error, convert_error_message(var)}
    end
  end

  defp convert_to_atom(operator) do
    {:ok, String.to_existing_atom(operator)}
  rescue ArgumentError ->
    {:error, convert_error_message(operator)}
  end

  defp convert_error_message(var) do
    "Unexpected input: '" <> inspect(var) <> "'"
  end
end
