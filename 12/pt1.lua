require("common")
local input = LoadData("12/test.txt")

local grid = {}
for i, line in ipairs(input) do
  table.insert(grid, {})
  for j = 1, #line do
    grid[i][j] = line:sub(j, j)
  end
end

Queue = {}
function Queue:new(t)
  t = t or {}
  self.__index = self
  setmetatable(t, Queue)
  return t
end

function Queue:add(item)
  self[#self + 1] = item
end

function Queue:pop()
  local out = table.remove(self, 1)
  return out[1], out[2], out[3]
end

function Queue:notEmpty()
  if self[1] == nil then
    return false
  end
  return true
end

local starting_row, staring_col, ending_row, ending_col = 0, 0, 0, 0
for r, row in ipairs(grid) do
  for c, item in ipairs(row) do
    if item == "S" then
      starting_row, staring_col = r, c
      -- change value to make them act as other cols
      grid[r][c] = "a"
    elseif item == "E" then
      ending_row, ending_col = r, c
      -- change value to make them act as other cols
      grid[r][c] = "z"
    end
  end
end

-- starting positions have been already added because we already know its location
local visited = {}
local q = Queue:new()

visited[table.concat({ starting_row, staring_col })] = true
q:add({ 0, starting_row, staring_col })

while q:notEmpty() do
  local distance, row, column = q:pop()
  local potential_neighbours = { { row + 1, column }, { row - 1, column }, { row, column + 1 }, { row, column - 1 } }
  for _, value in ipairs(potential_neighbours) do
    local next_row, next_col = value[1], value[2]
    -- skip points outside of grid
    if next_row < 1 or next_col < 1 or next_row >= #grid + 1 or next_col >= #grid[1] + 1 then goto continue end
    -- skip points that have been already visited
    if visited[table.concat({ next_row, next_col })] == true then goto continue end
    -- visit only those points which "height" difference is one or less
    if string.byte(grid[next_row][next_col]) - string.byte(grid[row][column]) > 1 then goto continue end
    -- ending point reached
    if next_row == ending_row and next_col == ending_col then
      print(distance + 1)
      goto exit
    end
    visited[table.concat({ next_row, next_col })] = true
    q:add({ distance + 1, next_row, next_col })
    ::continue::
  end
end
::exit::
