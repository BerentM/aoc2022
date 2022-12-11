-- PART 1
local function read_input()
  local instructions = {}
  for line in io.lines("10/input.txt") do
    table.insert(instructions, line)
  end
  return instructions
end

local display_instructions = read_input()

local function mysplit(inputstr, sep)
  if sep == nil then sep = "%s" end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local X = 1
local cycle = 1
local check_pos = { 20, 60, 100, 140, 180, 220 }
local ans = {}

local function check(cur_cycle, x_value)
  for _, value in ipairs(check_pos) do
    if cur_cycle == value then
      table.insert(ans, x_value * value)
      print(x_value)
      return true
    end
  end
  return false
end

local function program_execution()
  for i = 1, #display_instructions do
    local instruction = mysplit(display_instructions[i])
    if instruction[1] == "noop" then
      cycle = cycle + 1
      check(cycle, X)
    elseif instruction[1] == "addx" then
      cycle = cycle + 1
      check(cycle, X)
      cycle = cycle + 1
      X = X + instruction[2]
      check(cycle, X)
    end
  end
end

while cycle <= 220 do
  program_execution()
end

local output = 0
for key, value in ipairs(ans) do
  print(key .. ": " .. value)
  output = output + value
end
print(output)

-- PART 2
local X = 1
local cycle = 1
local ans = { {}, {}, {}, {}, {}, {} }

local CRT = { 1 }

for i = 1, #display_instructions do
  local instruction = mysplit(display_instructions[i])
  if instruction[1] == "noop" then
    cycle = cycle + 1
    CRT[cycle] = X
  elseif instruction[1] == "addx" then
    cycle = cycle + 1
    CRT[cycle] = X

    cycle = cycle + 1
    X = X + instruction[2]
    CRT[cycle] = X
  end
end

for row = 0, 5 do
  for col = 0, 39 do
    local counter = row * 40 + col + 2
    if math.abs(CRT[counter - 1] - col) <= 1 then
      ans[row + 1][col + 1] = "##"
    else
      ans[row + 1][col + 1] = "  "
    end
  end
end

for _, value in ipairs(ans) do
  print(table.concat(value))
end
