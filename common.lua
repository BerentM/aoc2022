---Read file as list of strings, each element represents one row.
---@param path string
---@return table
function LoadData(path)
  local out = {}
  for line in io.lines(path) do
    table.insert(out, line)
  end
  return out
end

---Split string by separator.
---@param inputstr string
---@param sep string
---@return table
function Split(inputstr, sep)
  sep = sep or "%s"
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

---Create shalow copy of table.
---@param t table
---@return table
function table.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end
