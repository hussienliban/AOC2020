defmodule AOC.Day2 do
  @input_file "./data/day_2_input"
  def read_input() do
    @input_file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ~r/[-: ]/, trim: true))
    |> Stream.map(fn [min, max, char, pwd] ->
      {String.to_integer(min), String.to_integer(max), char, pwd}
    end)
    |> Enum.to_list()
  end

  def part1 do
    input = read_input()

    input
    |> Enum.filter(fn {min, max, char, pwd} ->
      pwd
      |> String.graphemes()
      |> Enum.count(&(&1 == char))
      |> Kernel.in(min..max)
    end)
    |> length
  end

  def part2 do
    input = read_input()

    input
    |> Enum.filter(fn {pos1, pos2, char, pwd} ->
      case [in_position(pwd, char, pos1), in_position(pwd, char, pos2)] do
        [false, true] ->
          true

        [true, false] ->
          true

        _ ->
          false
      end
    end)
    |> length
  end

  defp in_position(pwd, char, pos) when is_integer(pos) do
    String.match?(pwd, ~r/^.{#{pos - 1}}[#{char}]/)
  end
end
