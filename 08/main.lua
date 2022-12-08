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

local function side_max(row, column)
  local max_right = math.max(unpack(forest_matrix[row], column + 1, #forest_matrix[row]))
  local max_left = math.max(unpack(forest_matrix[row], 1, column - 1))
  return { max_right, max_left }
end

local function up_down_max(row, column)
  local forest_column = {}
  for i = 1, #forest_matrix do
    table.insert(forest_column, forest_matrix[i][column])
  end
  local top_max = math.max(unpack(forest_column, 1, row - 1))
  local bottom_max = math.max(unpack(forest_column, row + 1, #forest_matrix))
  return { top_max, bottom_max }
end

local visible_trees = 0
for r = 2, #forest_matrix[1] - 1 do
  for c = 2, #forest_matrix - 1 do
    local current_tree = forest_matrix[r][c]
    local max_right, max_left = unpack(side_max(r, c))
    local up_max, down_max = unpack(up_down_max(r, c))
    if current_tree > max_right or current_tree > max_left or current_tree > up_max or current_tree > down_max then
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
