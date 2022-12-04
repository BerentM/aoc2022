-- PART 1
local function read_elf_assignments()
  local elf_asignments = {}
  for line in io.lines("04/input.txt") do
    table.insert(elf_asignments, line)
  end
  return elf_asignments
end

---parse input, and create table containing pair of elfs
---@param elfs_asignment string
---@return table
local function separate_elfs(elfs_asignment)
  local elf_pair = {}
  for area in string.gmatch(elfs_asignment, '([^,]+)') do
    table.insert(elf_pair, area)
  end
  return elf_pair
end

---parse elf asignment
---@param elf_asignment string
---@return table
local function elf_asignment_borders(elf_asignment)
  local elf_tasks = {}
  for area in string.gmatch(elf_asignment, '([^-]+)') do
    table.insert(elf_tasks, tonumber(area))
  end
  return elf_tasks
end

---check if elf workload overlap
---@param first_elf string
---@param second_elf string
---@return integer
local function validate_elfs_workload(first_elf, second_elf)
  local first_elf_tasks = elf_asignment_borders(first_elf)
  local second_elf_tasks = elf_asignment_borders(second_elf)
  if (first_elf_tasks[1] >= second_elf_tasks[1]) and (first_elf_tasks[2] <= second_elf_tasks[2]) then
    return 1
  elseif (first_elf_tasks[1] <= second_elf_tasks[1] and first_elf_tasks[2] >= second_elf_tasks[2]) then
    return 1
  end
  return 0
end

local elf_asignments = read_elf_assignments()
local overlap_count = 0
for _, value in ipairs(elf_asignments) do
  local elf_pair = separate_elfs(value)
  overlap_count = overlap_count + validate_elfs_workload(elf_pair[1], elf_pair[2])
end

print(overlap_count)

-- PART 2
---check if elf workload overlap at all
---@param first_elf string
---@param second_elf string
---@return integer
local function validate_elfs_workload(first_elf, second_elf)
  local first_elf_tasks = elf_asignment_borders(first_elf)
  local second_elf_tasks = elf_asignment_borders(second_elf)
  if first_elf_tasks[1] >= second_elf_tasks[1] and first_elf_tasks[1] <= second_elf_tasks[2] then
    return 1
  elseif second_elf_tasks[1] >= first_elf_tasks[1] and second_elf_tasks[1] <= first_elf_tasks[2] then
    return 1
  end
  return 0
end

local overlap_count = 0
for _, value in ipairs(elf_asignments) do
  local elf_pair = separate_elfs(value)
  overlap_count = overlap_count + validate_elfs_workload(elf_pair[1], elf_pair[2])
end

print(overlap_count)
