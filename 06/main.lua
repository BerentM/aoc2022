-- PART 1
local function read_stream()
  local file = io.open("06/input.txt", "r")
  if file == nil then return "" end
  local output = file:read("*a")
  file:close()
  return output
end

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

local function substream(str, from, to)
  local output = {}
  for i=from, to do
    table.insert(output, str:sub(i, i))
  end
  return output
end

local stream = read_stream()

for i =1, #stream do
  if is_unique(substream(stream,i, i + 3)) == true then
    print(i + 3)
    break
  end
end

-- PART 2
for i =1, #stream do
  if is_unique(substream(stream, i, i+13)) == true then
    print(i + 13)
    break
  end
end
