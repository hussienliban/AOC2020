defmodule AOC.Day1 do
  @input_file "./data/day_1_input"
  def read_input() do
    @input_file
    |> File.stream!()
    |> Stream.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer()
    end)
    |> Enum.to_list()
  end

  def part1 do
    input = read_input()

    input
    |> Enum.reduce_while(nil, fn entry, _acc ->
      n_to_find = 2020 - entry

      case Enum.find(input, fn x -> x == n_to_find end) do
        nil -> {:cont, nil}
        x -> {:halt, entry * x}
      end
    end)
  end

  def part2() do
    input = read_input()

    try do
      for a <- input,
          b <- input,
          c <- input,
          a + b + c == 2020,
          do: throw({:break, {a, b, c}})
    catch
      {:break, {a, b, c}} -> a * b * c
    end
  end
end
