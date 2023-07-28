local db = require'nvim-confluence.database'

local unescape = function(content)
  return content:gsub("__ESCAPED__\'(.*)\'", "%1")
end
local source = {}

function source.new(fntransform)
    source.transformation = fntransform
    return setmetatable({}, { __index = source })
end

function source:is_available()
  return true
end

function source:get_keyword_pattern()
  return [[\k\+]]
end

function source:complete(request, callback)
  local items = {}
  local dbresult = db:pg_choose()
  for _, item in pairs(dbresult) do
    table.insert(items, {
      label = unescape(item.title) .. ' ('.. item.space .. ')',
      insertText = source.transformation(item.id, unescape(item.title), item.space)
    })
  end
  callback({
    items = items
  })
end

return source

