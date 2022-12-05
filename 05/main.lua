-- PART 1
-- Starting crate positions
--         [J]         [B]     [T]
--         [M] [L]     [Q] [L] [R]
--         [G] [Q]     [W] [S] [B] [L]
-- [D]     [D] [T]     [M] [G] [V] [P]
-- [T]     [N] [N] [N] [D] [J] [G] [N]
-- [W] [H] [H] [S] [C] [N] [R] [W] [D]
-- [N] [P] [P] [W] [H] [H] [B] [N] [G]
-- [L] [C] [W] [C] [P] [T] [M] [Z] [W]
--  1   2   3   4   5   6   7   8   9

local starting_crate_positions = {
  [1] = { "D", "T", "W", "N", "L" },
  [2] = { "H", "P", "C" },
  [3] = { "J", "M", "G", "D", "N", "H", "P", "W", },
  [4] = { "L", "Q", "T", "N", "S", "W", "C", },
  [5] = { "N", "C", "H", "P", },
  [6] = { "B", "Q", "W", "M", "D", "N", "H", "T", },
  [7] = { "L", "S", "G", "J", "R", "B", "M", },
  [8] = { "T", "R", "B", "V", "G", "W", "N", "Z", },
  [9] = { "L", "P", "N", "D", "G", "W", },
}

--- define stack and its methods
Stack = {}
Stack.__index = Stack
---Create new, empty stack
---@return table
function Stack.new() return setmetatable({}, Stack) end

---Add item on top of a stack
---@param item any
function Stack:push(item)
  self[#self + 1] = item
end

---Pop item from top of a stack
---@return unknown
function Stack:pop()
  assert(#self > 0, "Stack is empty")
  local output = self[#self]
  self[#self] = nil
  return output
end

---Create table build from stacks
---@param stack_input table
---@return table
local function load_stack(stack_input)
  local output = {}
  for i = 1, #stack_input do
    output[i] = Stack:new()
    for j = #stack_input[i], 1, -1 do
      output[i]:push(stack_input[i][j])
    end
  end
  return output
end

---Read input data
---@return table
local function read_crate_movement()
  local movement = {}
  for line in io.lines("05/input.txt") do
    table.insert(movement, line)
  end
  return movement
end

---Split text on " " char and parse its output
---@param crate_movement string
---@return table
local function parse_crate_movement(crate_movement)
  local crate_operations = {}
  for movement in string.gmatch(crate_movement, '([^ ]+)') do
    table.insert(crate_operations, movement)
  end
  return { crate_operations[2], crate_operations[4], crate_operations[6], }
end


local crate_movement = read_crate_movement()
local crate_stack = load_stack(starting_crate_positions)
for i = 1, #crate_movement do
  local move = parse_crate_movement(crate_movement[i])
  for _ = 1, tonumber(move[1]) do
    crate_stack[tonumber(move[3])]:push(crate_stack[tonumber(move[2])]:pop())
  end
end

local top_crates = ""
for i = 1, #crate_stack do
  top_crates = top_crates .. crate_stack[i][#crate_stack[i]]
end
print(top_crates)

-- PART 2
local crate_movement = read_crate_movement()
local crate_stack = load_stack(starting_crate_positions)
for i = 1, #crate_movement do
  local move = parse_crate_movement(crate_movement[i])
  local popped_crates = {}
  -- use pop to remove top crates
  for _ = 1, tonumber(move[1]) do
    table.insert(popped_crates, crate_stack[tonumber(move[2])]:pop())
  end
  -- rearange popped crates to match initial order
  for j = #popped_crates, 1, -1 do
    crate_stack[tonumber(move[3])]:push(popped_crates[j])
  end
end

local top_crates = ""
for i = 1, #crate_stack do
  top_crates = top_crates .. crate_stack[i][#crate_stack[i]]
end
print(top_crates)
