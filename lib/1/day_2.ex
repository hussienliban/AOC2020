defmodule AOC.Day2 do
  @input_file "./data/day_2_input"
  def read_input() do
    @input_file
    |> File.stream!()
    |> Stream.map(fn line ->
      line
      |> String.trim()
    end)
    |> Enum.to_list()
  end

  def part1 do
    input = read_input()

    input
    |> Enum.map(fn line ->
      [min, max, char, pwd] =
        line
        |> String.split(~r{:|-|\s}, parts: 4)
        |> Enum.map(&String.trim/1)

      length_in_pwd =
        pwd
        |> String.graphemes()
        |> Enum.group_by(&String.first/1)
        |> Map.get(char, [])
        |> length()

      [String.to_integer(min), String.to_integer(max), length_in_pwd]
    end)
    |> Enum.filter(&check_pwd/1)
    |> length
  end

  defp check_pwd([min, max, number]) when number >= min and number <= max, do: true

  defp check_pwd(_), do: false
end
