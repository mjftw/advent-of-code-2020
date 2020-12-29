defmodule AdventOfCode.Day1 do
  @input_file Path.join(:code.priv_dir(:advent_of_code), "day1_input")
  @intended_sum 2020

  def run() do
    @input_file
    |> read_input()
    |> find_pairs_with_sum(@intended_sum)
    |> Enum.map(fn {x, y} -> x * y end)
  end

  @spec read_input(String.t()) :: [integer]
  defp read_input(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  @spec find_pairs_with_sum([number], number) :: [{number, number}]
  defp find_pairs_with_sum(input, sum) do
    for x <- input, y <- input, x != y and x + y == sum, do: {x, y}
  end
end
