local Inspect = require("lib/inspect")
    
function round(n)
  return math.floor((math.floor(n*2) + 1)/2)
end

function printvar(v)
--  Inspect(v)
  print(Inspect(v))
end

function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
          copy[deepcopy(orig_key)] = deepcopy(orig_value)
      end
      setmetatable(copy, deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
      copy = orig
  end
  return copy
end

function copyarray(array)
  local a = {}
  for i = 1, #array do
    a[i] = array[i]
  end
  return a
end

function copytable(keysTable)
  local t = {}
  for k,v in pairs(keysTable) do
    t[k] = v
  end
  return t
end

function arraytotable(array) --table indexed on itself
  local t = {}
  for i = 1, #array do
    t[array[i]] = array[i]
  end
  return t
end

function tabletoarray(keysTable)
  local a = {}
  for k,v in pairs(keysTable) do
    table.insert(a, v)
  end
  return a
end

function appendArrayToArray(target, array)
  for i = 1, #array do
    table.insert(target, array[i])
  end
end

function split(string, inSplitPattern, outResults )

   if not outResults then
      outResults = { }
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( string, inSplitPattern, theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( string, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( string, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( string, theStart ) )
   return outResults
end


function shuffleTable(table)    
  assert(type(table) == "table", "shuffleTable() expected a table, got nil")
  for i = #table, 2, -1 do
    local n = math.random(i)
    table[i], table[n] = table[n], table[i]
  end
end
