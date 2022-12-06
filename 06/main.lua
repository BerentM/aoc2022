-- PART 1
local function read_stream()
  local file = io.open("06/input.txt", "r")
  if file == nil then return "" end
  local output = file:read("*a")
  file:close()
  return output
end

local function is_unique(str)
  local t = {}
  for i = 1, #str do
    table.insert(t, str:sub(i, i))
  end
  for _, value in ipairs(t) do
    local _, n = str:gsub(value, "")
    if n > 1 then
      return false
    end
  end
  return true
end

local stream = read_stream()

for i = 1, #stream do
  if is_unique(stream:sub(i, i + 3)) == true then
    print(i + 3)
    break
  end
end

-- PART 2
for i = 1, #stream do
  if is_unique(stream:sub(i, i + 13)) == true then
    print(i + 13)
    break
  end
end
