IO.puts "Advent Of Code Day 1"

input = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

numList = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
inputList = String.split input, "\n"

defmodule ModuleStuff do

  def doStuff(charList) do
    "#{List.first(charList)}#{List.last(charList)}"
  end

  def addListTogether(numList) do
    Enum.reduce(numList, 0,
      fn x, acc ->
        acc + String.to_integer(x)
      end
    )
  end

  def tortureToExtractTheNum(string, matcherList) do
    containedNums = Enum.filter(matcherList, fn x -> String.contains?(string, x) end)
    stringToNumList = %{"one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5", "six"=>"6", "seven"=>"7", "eight"=>"8", "nine"=>"9"}

    recurseAndGetNumsInOrder(string, containedNums, []) |> Enum.reverse |> Enum.reduce("", fn numStr, acc -> acc <> Map.fetch!(stringToNumList, numStr) end)

  end

  def recurseAndGetNumsInOrder(string, matcherList, currentColl) do
    unless Enum.empty?(matcherList) do
      startingNum = Enum.find(matcherList, fn x -> String.starts_with?(string, x) end)
      unless startingNum == nil do
        recurseAndGetNumsInOrder(String.slice(string, 1, 100), Enum.reject(matcherList, fn x -> x == startingNum end), [startingNum | currentColl])
      else
        recurseAndGetNumsInOrder(String.slice(string, 1,100), matcherList, currentColl)
      end
    else
      currentColl
    end
  end

end

outputList = Enum.map(inputList,
  fn string ->
    String.split(string, ~r{[0-9]+}, trim: true, include_captures: true) |> Enum.map(
      fn listItem ->
        unless String.match?(listItem, ~r{[0-9]+}) do
          if String.contains?(listItem, numList) do
            ModuleStuff.tortureToExtractTheNum(listItem, numList)
          else
            ""
          end
        else
          listItem
        end
      end
    ) |> Enum.reject(fn x -> x == "" end) |> List.to_string
  end
) |> List.delete("") |> Enum.map(fn x -> String.codepoints(x) |> ModuleStuff.doStuff end)

IO.puts(ModuleStuff.addListTogether(outputList))
