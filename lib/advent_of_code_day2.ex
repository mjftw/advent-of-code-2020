defmodule AdventOfCode.Day2 do
  @input_file Path.join(:code.priv_dir(:advent_of_code), "day2_input")

  def run_part1() do
    @input_file
    |> read_input()
    |> Enum.map(fn input ->
      input
      |> parse_input()
      |> password_valid?()
    end)
    |> Enum.count(& &1)
  end

  @doc """
  Reads the input lines from a file and returns a tuple of
    {min_occurrences, max_occurrences, rule_char, password}.
  Expected file format:
    min-max char: password
  E.g.
    1-3 d: floopydoop
  """
  @spec read_input(String.t()) :: [{pos_integer, pos_integer, char, String.t()}]
  defp read_input(file) do
    file
    |> File.read!()
    |> String.split("\n")
  end

  @doc """
  No error checking at all as all the inputs are known and valid.
  """
  @spec parse_input(String.t()) :: {pos_integer, pos_integer, char, String.t()}
  defp parse_input(line) do
    [rule, password] = String.split(line, ":")
    [range, letter] = String.split(rule, " ")
    [min_char, max_char] = String.split(range, "-")

    {
      String.to_integer(min_char),
      String.to_integer(max_char),
      String.trim(letter),
      String.trim(password)
    }
  end

  @spec password_valid?({pos_integer, pos_integer, char, String.t()}) :: boolean
  defp password_valid?({min, max, char, password}) do
    password
    |> String.graphemes()
    |> Enum.count(&(&1 == char))
    |> num_in_range(min, max)
  end

  defp num_in_range(num, min, max) do
    min <= num and num <= max
  end
end
