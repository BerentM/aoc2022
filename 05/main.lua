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

--- define stack and its methods
Stack = {}
Stack.__index = Stack
---Create Stack with some data in it, if input == nil returns empty table
---@param list table
---@return table
function Stack:new(list)
  if list == nil then return {} end
  local data = list
  setmetatable(data, Stack)
  return data
end

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

local crate_operations = read_crate_movement()
local crate_stack = {
  [1] = Stack:new({ "D", "T", "W", "N", "L" }),
  [2] = Stack:new({ "H", "P", "C" }),
  [3] = Stack:new({ "J", "M", "G", "D", "N", "H", "P", "W", }),
  [4] = Stack:new({ "L", "Q", "T", "N", "S", "W", "C", }),
  [5] = Stack:new({ "N", "C", "H", "P", }),
  [6] = Stack:new({ "B", "Q", "W", "M", "D", "N", "H", "T", }),
  [7] = Stack:new({ "L", "S", "G", "J", "R", "B", "M", }),
  [8] = Stack:new({ "T", "R", "B", "V", "G", "W", "N", "Z", }),
  [9] = Stack:new({ "L", "P", "N", "D", "G", "W", }),
}

for i = 1, #crate_operations do
  local move = parse_crate_movement(crate_operations[i])
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
local crate_operations = read_crate_movement()
local crate_stack = {
  [1] = Stack:new({ "D", "T", "W", "N", "L" }),
  [2] = Stack:new({ "H", "P", "C" }),
  [3] = Stack:new({ "J", "M", "G", "D", "N", "H", "P", "W", }),
  [4] = Stack:new({ "L", "Q", "T", "N", "S", "W", "C", }),
  [5] = Stack:new({ "N", "C", "H", "P", }),
  [6] = Stack:new({ "B", "Q", "W", "M", "D", "N", "H", "T", }),
  [7] = Stack:new({ "L", "S", "G", "J", "R", "B", "M", }),
  [8] = Stack:new({ "T", "R", "B", "V", "G", "W", "N", "Z", }),
  [9] = Stack:new({ "L", "P", "N", "D", "G", "W", }),
}
for i = 1, #crate_operations do
  local move = parse_crate_movement(crate_operations[i])
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
