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

end

outputList = Enum.map(inputList,
  fn string ->
    mixedList = String.split(string, ~r{[0-9]+}, trim: true, include_captures: true)
    Enum.m
  end
)


#IO.puts(ModuleStuff.addListTogether(tl Enum.reverse(outputList)))
