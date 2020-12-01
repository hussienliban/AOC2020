defmodule AOC.Day1 do
  @input_file "./data/day_1_input"
  def read_input() do
    File.read!(@input_file)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end

  def process do
    input = read_input()

    input
    |> Enum.map(fn num ->
      Enum.filter(input, &(&1 + num == 2020))
    end)
    |> List.flatten()
    |> solve
  end

  def solve([a, b]), do: a * b
end
