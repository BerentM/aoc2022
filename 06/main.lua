-- PART 1
local function read_stream()
  local file = io.open("06/input.txt", "r")
  if file == nil then return "" end
  local output = file:read("*a")
  file:close()
  return output
end

local stream_table = {}
local stream = read_stream()
_ = stream:gsub(".", function(c) table.insert(stream_table, c) end)

local function is_unique(t)
  local str = table.concat(t)
  for _, value in ipairs(t) do
    local _, n = str:gsub(value, "")
    if n > 1 then
      return false
    end
  end
  return true
end

local function substream(t, from, to)
  local output = {}
  for index, value in ipairs(t) do
    if index >= from and index <= to then
      table.insert(output, value)
    end
    if index >= to then
      return output
    end
  end
  return output
end

for index, _ in ipairs(stream_table) do
  if is_unique(substream(stream_table, index, index + 3)) == true then
    print(index + 3)
    break
  end
end

-- PART 2
for index, _ in ipairs(stream_table) do
  if is_unique(substream(stream_table, index, index + 13)) == true then
    print(index + 13)
    break
  end
end
