defmodule Helpers do
  @moduledoc """
  Helpers module for parsing and converting data purposes
  """

  @allowed_parsed_elements 3

  @doc """
  Initial User input parsing with regular expression

  ## Examples
      iex> Helpers.parse_input("1+2")
      {:ok, {"1", "+", "2"}}
  """
  @spec parse_input(String.t()) :: {:ok, tuple()} | {:error, String.t()}
  def parse_input(input) do
    parsed_input = Regex.scan(~r{\d+\.?\d+|\d+|[+*/-]|[\w]+}, input) |> List.flatten() |> List.to_tuple()

    case tuple_size(parsed_input) do
      @allowed_parsed_elements -> {:ok, parsed_input}
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
  def convert_data(parsed_input) do
    {var1, operator, var2} = parsed_input
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
      {var, _} -> {:ok, var}
      :error -> {:error, convert_error_message(var)}
    end
  end

  defp convert_to_atom(operator) do
    try do
      {:ok, String.to_existing_atom(operator)}
    rescue ArgumentError ->
      {:error, convert_error_message(operator)}
    end
  end

  defp convert_error_message(var) do
    ["Cannot convert '" <> inspect(var) <> "' to integer\n"]
  end
end
