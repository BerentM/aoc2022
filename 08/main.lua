-- PART 1
local function read_input()
  local map = {}
  for line in io.lines("08/input.txt") do
    table.insert(map, line)
  end
  return map
end

local forest_map = read_input()

local function split_map(map_row)
  local output = {}
  for i = 1, #map_row do
    table.insert(output, tonumber(map_row:sub(i, i)))
  end
  return output
end

local forest_matrix = {}
for _, map_row in ipairs(forest_map) do
  table.insert(forest_matrix, split_map(map_row))
end

local unpack = unpack or table.unpack

local visible_trees = 0
for r = 2, #forest_matrix[1] - 1 do
  for c = 2, #forest_matrix - 1 do
    local forest_column = {}
    for i = 1, #forest_matrix do
      table.insert(forest_column, forest_matrix[i][c])
    end

    local current_tree = forest_matrix[r][c]
    local right = math.max(unpack(forest_matrix[r], c + 1, #forest_matrix[r]))
    local left = math.max(unpack(forest_matrix[r], 1, c - 1))
    local up = math.max(unpack(forest_column, 1, r - 1))
    local down = math.max(unpack(forest_column, r + 1, #forest_matrix))

    if current_tree > right or current_tree > left or current_tree > up or current_tree > down then
      visible_trees = visible_trees + 1
    end
  end
end

print(#forest_matrix * 2 + (#forest_matrix[1] - 2) * 2 + visible_trees)

-- PART 2
local result = 0
for r = 2, #forest_matrix[1] do
  for c = 2, #forest_matrix do
    local right, left, top, bottom = 0, 0, 0, 0

    local current_tree = forest_matrix[r][c]
    -- view to the right
    for t = c + 1, #forest_matrix[r] do
      right = right + 1
      if current_tree <= forest_matrix[r][t] then break end
    end
    -- view to the left
    for t = c - 1, 1, -1 do
      left = left + 1
      if current_tree <= forest_matrix[r][t] then break end
    end
    -- view to the top
    for t = r - 1, 1, -1 do
      top = top + 1
      if current_tree <= forest_matrix[t][c] then break end
    end
    -- view to the bottom
    for t = r + 1, #forest_matrix do
      bottom = bottom + 1
      if current_tree <= forest_matrix[t][c] then break end
    end
    -- calculate scenic score for each tree
    local scenic_score = right * left * top * bottom
    if result < scenic_score then result = scenic_score end
  end
end

print(result)
