-- PART 1
local function read_stream()
  local file = assert(io.open("06/input.txt", "r"))
  local output = file:read("*a")
  file:close()
  return output
end

local function is_unique(str)
  for i = 1, #str do
    local _, n = str:gsub(str:sub(i, i), "")
    if n > 1 then return false end
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
