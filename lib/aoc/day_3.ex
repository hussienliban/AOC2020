defmodule AOC.Day3 do
  @input_file "./data/day_3_input"
  @steps [
    [3, 1],
    [1, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ]
  def read_input() do
    @input_file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "\n"))
    |> Enum.to_list()
    |> List.flatten()
  end

  def part1 do
    input = read_input()
    len = input |> hd |> String.length()

    trees_count(input, len, @steps |> hd)
  end

  def part2 do
    input = read_input()
    len = input |> hd |> String.length()

    Enum.reduce(@steps, 1, fn step, acc ->
      acc * trees_count(input, len, step)
    end)
  end

  defp trees_count(input, len, [x, y]) do
    input
    |> Enum.with_index(0)
    |> Enum.reduce_while(%{x: 0, y: 0, trees: 0}, fn {line, idx}, state ->
      geo = String.split(line, "", trim: true)

      char = Enum.at(geo, rem(state.x, len))

      cond do
        rem(idx, y) != 0 ->
          {:cont, state}

        char == "#" ->
          state =
            state
            |> Map.update(:x, x, fn value -> value + x end)
            |> Map.update(:y, y, fn value -> value + y end)
            |> Map.update(:trees, 0, fn value -> value + 1 end)

          {:cont, state}

        char == "." ->
          state =
            state
            |> Map.update(:x, x, fn value -> value + x end)
            |> Map.update(:y, y, fn value -> value + y end)

          {:cont, state}
      end
    end)
    |> Map.fetch!(:trees)
  end
end
