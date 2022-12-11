-- PART 1
local unpack = unpack or table.unpack

local function read_input()
  local movement = {}
  for line in io.lines("09/test.txt") do
    table.insert(movement, line)
  end
  return movement
end

local movement_order = read_input()

local function mysplit(inputstr, sep)
  if sep == nil then sep = "%s" end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function table.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local head = { 0, 0 }
local tail = { 0, 0 }

local head_moves = {}
local tail_moves = {}

for _, value in ipairs(movement_order) do
  local direction, steps = unpack(mysplit(value))
  for _ = 1, steps do
    local prev_head = table.shallow_copy(head)
    if direction == "R" then
      head[1] = head[1] + 1
    elseif direction == "L" then
      head[1] = head[1] - 1
    elseif direction == "U" then
      head[2] = head[2] + 1
    elseif direction == "D" then
      head[2] = head[2] - 1
    end
    table.insert(head_moves, table.concat(head, ","))

    if math.abs(head[1] - tail[1]) > 1 or math.abs(head[2] - tail[2]) > 1 then
      tail = table.shallow_copy(prev_head)
    end

    tail_moves[table.concat(tail, ",")] = true
  end
end

local output = {}
for key, _ in pairs(tail_moves) do
  table.insert(output, key)
end
print(#output)

-- PART 2

local ropes = {
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
  { 0, 0 },
}
local tail_moves = {}


for _, value in ipairs(movement_order) do
  local direction, steps = unpack(mysplit(value))
  for _ = 1, steps do
    local head = ropes[1]
    if direction == "R" then
      head[1] = head[1] + 1
    elseif direction == "L" then
      head[1] = head[1] - 1
    elseif direction == "U" then
      head[2] = head[2] + 1
    elseif direction == "D" then
      head[2] = head[2] - 1
    end
    for i = 2, #ropes do
      -- TODO: something is wrong here
      head = ropes[i - 1]
      local tail = ropes[i]
      if math.abs(head[1] - tail[1]) > 1 or math.abs(head[2] - tail[2]) > 1 then
        ropes[i] = table.shallow_copy(ropes[i - 1])
      end
      if i == #ropes then
        tail_moves[table.concat(tail, ",")] = true
      end
    end
  end
end

local output = {}
for key, _ in pairs(tail_moves) do
  table.insert(output, key)
end
print(#output)
