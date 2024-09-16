defmodule HelpersTest do
  use ExUnit.Case, async: true
  doctest Helpers

  describe "#parse_input" do
    test "with valid data" do
      input = "1 / 2"
      expected_result = {"1", "/", "2"}
      result = Helpers.parse_input(input)

      assert result == {:ok, expected_result}
    end

    test "with invalid first variable" do
      input = "1o + 2"
      expected_result = "incorrect input has been provided"
      result = Helpers.parse_input(input)

      assert result == {:error, expected_result}
    end

    test "with invalid second variable" do
      input = "10 + 2o"
      expected_result = "incorrect input has been provided"
      result = Helpers.parse_input(input)

      assert result == {:error, expected_result}
    end

    test "with invalid operator" do
      input = "10 ** 20"
      expected_result = "incorrect input has been provided"
      result = Helpers.parse_input(input)

      assert result == {:error, expected_result}
    end

    test "when list is provided" do
      input = "10 + [1, 2, 3]"
      expected_result = "incorrect input has been provided"
      result = Helpers.parse_input(input)

      assert result == {:error, expected_result}
    end

    test "when tuple is provided" do
      input = "10 + {1, 2, 3}"
      expected_result = "incorrect input has been provided"
      result = Helpers.parse_input(input)

      assert result == {:error, expected_result}
    end
  end

  describe "#convert_data" do
    test "with valid data" do
      input = {"1", "*", "2"}
      expected_result = {1.0, :*, 2.0}
      result = Helpers.convert_data(input)

      assert result == {:ok, expected_result}
    end

    test "when first variable is incorrect" do
      input = {":a", "*", "2"}
      expected_result = ["Cannot convert '\":a\"' to float\n"]
      result = Helpers.convert_data(input)

      assert result == {:error, expected_result}
    end

    test "when second variable is incorrect" do
      input = {"1", "*", "{3, 2, 1}"}
      expected_result = ["Cannot convert '\"{3, 2, 1}\"' to float\n"]
      result = Helpers.convert_data(input)

      assert result == {:error, expected_result}
    end

    test "when converting to float is failed" do
      input = {"1", "*", "12.2asd}"}
      expected_result = "trailing garbage in ‹12.2›"
      result = Helpers.convert_data(input)

      assert result == {:error, expected_result}
    end

    test "when operator is incorrect" do
      input = {"1", "hello world", "3"}
      expected_result = ["Cannot convert '\"hello world\"' to float\n"]
      result = Helpers.convert_data(input)

      assert result == {:error, expected_result}
    end
  end

  describe "exit_command?/1" do
    test "returns {:exit, 'See you!'} when input is 'exit'" do
      assert Helpers.exit_command?("exit") == {:exit, "See you!"}
    end

    test "returns {:ok, 'proceed further'} for other inputs" do
      assert Helpers.exit_command?("hello") == {:ok, "proceed further"}
      assert Helpers.exit_command?("123") == {:ok, "proceed further"}
      assert Helpers.exit_command?("") == {:ok, "proceed further"}
    end
  end
end
