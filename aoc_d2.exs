inputList = File.read!("inputs/d2.txt") |> String.split("\n")
colourList = ["red", "green", "blue"]
currentCubeLimits = %{"red" => 12, "green" => 13, "blue" => 14}

defmodule ModuleStuff do
  def getColourValue(values, colour) do
    {value, _string} = Enum.find(values, "0" ,fn value -> String.contains?(value, colour) end) |> String.split(" ") |> List.first() |> Integer.parse()
    value
  end
end

encapsulatedGamesList = Enum.map(inputList,
  fn inputLine ->
    dividedString = String.split(inputLine, ":")
    {gameNum, _string} = List.first(dividedString) |> String.split(" ") |> List.last() |> Integer.parse()
    roundList = List.last(dividedString) |> String.split(";") |> Enum.map(
      fn roundText ->
        values = String.split(roundText, ",") |> Enum.map(fn strToTrim -> String.trim(strToTrim) end)
        %{
          "red"   => ModuleStuff.getColourValue(values, "red"),
          "green" => ModuleStuff.getColourValue(values, "green"),
          "blue"  => ModuleStuff.getColourValue(values, "blue")
        }
      end
    )
    {gameNum, roundList}
  end
)

partOneSum = Enum.reject(encapsulatedGamesList,
  fn game ->
    {_gameNum, gameRounds} = game
    Enum.any?(gameRounds,
      fn roundMap ->
        Enum.any?(colourList,
          fn colour ->
            #IO.puts("Red is #{Map.fetch!(roundMap, "red")}, Green is #{Map.fetch!(roundMap, "green")}, Blue is #{Map.fetch!(roundMap, "blue")}")
            Map.fetch!(roundMap, colour) > Map.fetch!(currentCubeLimits, colour)
          end
        )
      end)
  end
) |> Enum.map(
  fn game ->
    {gameNum, _gameRounds} = game
    gameNum
  end
) |> List.foldl(0, fn x, acc -> acc + x end)

partTwoSum = Enum.map(encapsulatedGamesList,
  fn game ->
    {_gameNum, gameRounds} = game
    {x, y, z} = List.foldl(gameRounds, {0, 0, 0},
      fn round, acc ->
        {redMax, greenMax, blueMax} = acc
        red = Map.fetch!(round, "red")
        green = Map.fetch!(round, "green")
        blue = Map.fetch!(round, "blue")

        {
          if red > redMax do red else redMax end,
          if green > greenMax do green else greenMax end,
          if blue > blueMax do blue else blueMax end
        }
      end
    )
    x * y * z
  end
) |> List.foldl(0, fn x, acc -> acc + x end)

IO.puts("Part one answer = #{partOneSum}")
IO.puts("Part two answer is = #{partTwoSum}")
