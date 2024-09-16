defmodule CalcTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  doctest Calc

  describe "#loop/0" do
    test "loop/0 with valid input" do
      values = [
        {:input, "1 + 2\n", :output, "3.0\n\n"},
        {:input, "3 * 2\n", :output, "6.0\n\n"},
        {:input, "10 / 2.5\n", :output, "4.0\n\n"},
        {:input, "4 - 6.5\n", :output, "-2.5\n\n"},
        {:input, "-4 - 6.5\n", :output, "-10.5\n\n"},
      ]
      exit_input = "exit\n"

      Enum.each(values, fn(value) ->
        {:input, user_input, :output, expected_output} = value
        inputs = user_input <> exit_input
        output = capture_io([input: inputs, capture_prompt: false],  fn ->
          Calc.loop()
        end)

        assert output === "Result: " <> expected_output <> "See you!\n"
      end)
    end

    test "loop/0 with invalid input" do
      values = [
        {:input, "1 ++ 3\n", :output, "incorrect input has been provided\n"},
        {:input, "1 + first_value\n", :output, "Cannot convert '\"first_value\"' to float\n\n"},
        {:input, "2 * second_value\n", :output, "Cannot convert '\"second_value\"' to float\n\n"},
        {:input, "IncorrectF * incorrect_s\n", :output, "Cannot convert '\"IncorrectF\"' to float\n\n"},
        {:input, "10 / 0\n", :output, "you cannot divide by 0\n"},
        {:input, "0 / dummy_value\n", :output, "Cannot convert '\"dummy_value\"' to float\n\n"},
        {:input, "4 - o\n", :output, "Cannot convert '\"o\"' to float\n\n"},
      ]
      exit_input = "exit\n"

      Enum.each(values, fn(value) ->
        {:input, user_input, :output, expected_output} = value
        inputs = user_input <> exit_input
        output = capture_io([input: inputs, capture_prompt: false],  fn ->
          Calc.loop()
        end)

        assert output === expected_output <> "See you!\n"
      end)
    end
  end
end
