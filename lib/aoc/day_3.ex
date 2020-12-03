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
    trees_count(input, @steps |> hd)
  end

  def part2 do
    input = read_input()

    Enum.reduce(@steps, 1, fn step, acc ->
      acc * trees_count(input, step)
    end)
  end

  defp trees_count(input, [x, y]) do
    len = input |> hd |> String.length()

    input
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.with_index(0)
    |> Enum.reduce_while(%{x: 0, y: 0, trees: 0}, fn {line, idx}, state ->
      char = Enum.at(line, rem(state.x, len))

      cond do
        rem(idx, y) != 0 ->
          {:cont, state}

        char == "#" ->
          state =
            state
            |> Map.update(:x, x, &(&1 + x))
            |> Map.update(:y, y, &(&1 + y))
            |> Map.update(:trees, 0, &(&1 + 1))

          {:cont, state}

        char == "." ->
          state =
            state
            |> Map.update(:x, x, &(&1 + x))
            |> Map.update(:y, y, &(&1 + y))

          {:cont, state}
      end
    end)
    |> Map.fetch!(:trees)
  end
end
