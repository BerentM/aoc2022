local function read_input()
  local instructions = {}
  for line in io.lines("11/input.txt") do
    table.insert(instructions, line)
  end
  return instructions
end

local raw_data = read_input()

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

local monkey_input = {}
local monkey = {}
for i, value in ipairs(raw_data) do
  if i % 7 == 0 then
    table.insert(monkey_input, table.shallow_copy(monkey))
    monkey = {}
  else
    if value:sub(1, 1) == "M" then
      table.insert(monkey, value:sub(8, 8))
    else
      table.insert(monkey, mysplit(value, ":")[2])
    end
  end
end

local parsed_monkeys = {}
for _, value in ipairs(monkey_input) do
  parsed_monkeys[tonumber(value[1])] = {}
  parsed_monkeys[tonumber(value[1])]["items"] = mysplit(value[2], ", ")
  parsed_monkeys[tonumber(value[1])]["operation"] = { value[3]:sub(12, 12), value[3]:sub(13, 100) }
  parsed_monkeys[tonumber(value[1])]["test"] = { value[4]:match("%d+"), value[5]:match("%d+"), value[6]:match("%d+") }
  parsed_monkeys[tonumber(value[1])]["monkey_bussines"] = 0
end

local mod = 1
for i = 0, #parsed_monkeys do
  mod = mod * parsed_monkeys[i]["test"][1]
end

local function monkey_round()
  for i = 0, #parsed_monkeys do
    local m = parsed_monkeys[i]
    local num = 0
    local operation_result = 0
    for j = 1, #m["items"] do
      m["monkey_bussines"] = m["monkey_bussines"] + 1
      if m["operation"][2] == " old" then
        num = m["items"][j]
      else
        num = m["operation"][2]
      end
      if m["operation"][1] == "*" then
        operation_result = (m["items"][j] * num) % mod
      else
        operation_result = (m["items"][j] + num) % mod
      end
      if operation_result % m["test"][1] == 0 then
        table.insert(parsed_monkeys[tonumber(m["test"][2])]["items"], operation_result)
      else
        table.insert(parsed_monkeys[tonumber(m["test"][3])]["items"], operation_result)
      end
    end
    parsed_monkeys[i]["items"] = {}
  end
end

for i = 1, 10000 do
  monkey_round()
end

local output = {}
for i = 0, #parsed_monkeys do
  table.insert(output, parsed_monkeys[i]["monkey_bussines"])
end
table.sort(output)
print(table.concat(output, ", "))
print(output[#output]* output[#output-1])